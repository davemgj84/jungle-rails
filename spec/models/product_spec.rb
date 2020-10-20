require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    it 'Validates a new product' do
      new_category = Category.new(name: "Tests")
      new_product = Product.new(category: new_category, name: "hats", price_cents: 6000, quantity: 80)
      new_product.save
      expect(new_product).to be_valid
    end

    it 'Will not validate product without a name' do
      new_category = Category.new(name: "Tests")
      new_product = Product.new(category: new_category, name: nil, price_cents: 6000, quantity: 80)
      new_product.save
      expect(new_product).to_not be_valid
      expect(new_product.errors.full_messages).to include("Name can't be blank")
    end

    it 'Will not validate product without a price' do
      new_category = Category.new(name: "Tests")
      new_product = Product.new(category: new_category, name: "coats", price_cents: nil, quantity: 80)
      new_product.save
      expect(new_product).to_not be_valid
      expect(new_product.errors.full_messages).to include("Price can't be blank")
    end

    it 'Will not validate product without a quantity' do
      new_category = Category.new(name: "Tests")
      new_product = Product.new(category: new_category, name: "shoes", price_cents: 6000, quantity: nil)
      new_product.save
      expect(new_product).to_not be_valid
      expect(new_product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'Will not validate product without a category' do
      new_product = Product.new(category: nil, name: "pants", price_cents: 6000, quantity: 80)
      new_product.save
      expect(new_product).to_not be_valid
      expect(new_product.errors.full_messages).to include("Category can't be blank")
    end

  end

end