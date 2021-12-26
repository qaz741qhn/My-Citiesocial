require 'rails_helper'

RSpec.describe Cart, type: :model do
  context "基本功能" do
    it "把商品丟到購物車裡，購物車就有東西" do
      cart = Cart.new
      cart.add_item(2)
      expect(cart.empty?).to eq false
    end

    it "加相同種類商品到購物車，購買項目不會增加，數量會改變" do
      cart = Cart.new
      3.times {cart.add_item(1)}
      2.times {cart.add_item(2)}
      expect(cart.items.count).to eq 2
      expect(cart.items.first.quantity).to eq 3
    end

    it "商品可放入購物車，也可拿出來" do
      cart = Cart.new

      # v1 = Vendor.create(title: "v1")
      # p1 = Product.create(name: "aa", list_price: 20, sell_price: 10, vendor: v1)
      p1 = create(:product)

      cart.add_item(p1.id)
      expect(cart.items.first.product).to be_a Product
    end

    it "計算自己的總金額" do
      cart = Cart.new
      p1 = create(:product, sell_price: 5)
      p2 = create(:product, sell_price: 10)
      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.total_price).to eq 35
    end

    it "聖誕節全面打九折" do
      Timecop.freeze(Time.local(2021, 12, 25))

      cart = Cart.new
      p1 = create(:product, sell_price: 10)
      3.times { cart.add_item(p1.id) }

      expect(cart.total_price).to eq 27
    end
  end

  context "進階功能" do
    it "將購物車轉換成hash後存入session" do
      cart = Cart.new
      p1 = create(:product)
      p2 = create(:product)
      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.serialize).to eq cart_hash
    end

    it "將存放在session中的內容還原成購物車的hash內容" do
      cart = Cart.from_hash(cart_hash)

      expect(cart.items.first.quantity).to eq 3
    end

    private

    def cart_hash
      {
        "items" => [
          { "product_id" => 1, "quantity" => 3 },
          { "product_id" => 2, "quantity" => 2 }
        ]
      }
    end
  end
end
