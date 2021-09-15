require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'Validation Test' do
    it 'is not valid with empty attributes' do
      expect(Order.new).to_not be_valid
    end

    it 'is not valid if number already exist' do      
      expect{
        user = User.create!(email: "test@mail.com", password: "123456")
        Order.create!(user_id: user.id, number: "BO123456789", state: "processing", total: 100)
        Order.create!(user_id: user.id, number: "BO123456789", state: "processing", total: 100)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

  end

  context 'Add product as order_items' do
    
    user = User.create!(email: "test1@mail.com", password: "123456")
    order = Order.create!(user_id: user.id)
    variation = Variation.create!(name: "test")
    product = Product.create!(name: "test", description: "test product", price: 1)
    ProductVariation.create!(product_id: product.id, variation_id: variation.id, stock: 1, added_price: 1, sku: "123test")

    it 'add product' do      
      order.add_product(product.id, 1, variation.id)

      expect(order.order_items.count).to be(1)
    end
  end

  context 'Add product non-stock' do

    user = User.create!(email: "test2@mail.com", password: "123456")
    order = Order.create!(user_id: user.id)
    variation = Variation.create!(name: "test")
    product = Product.create!(name: "test", description: "test product", price: 1)
    ProductVariation.create!(product_id: product.id, variation_id: variation.id, stock: 0, added_price: 1, sku: "123test")

    it 'products with stock zero cant be added to cart' do
      order.add_product(product.id, 1, variation.id)
      expect(order.order_items.count).to be(0)
    end
  end
end