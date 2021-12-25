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

      v1 = Vendor.create(title: "v1")
      p1 = Product.create(name: "aa", list_price: 20, sell_price: 10, vendor: v1)

      cart.add_item(p1.id)
      expect(cart.items.first.product).to be_a Product
    end
  end

  context "進階功能" do
    
  end
end
