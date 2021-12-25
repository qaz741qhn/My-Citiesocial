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
  end

  context "進階功能" do
    
  end
end
