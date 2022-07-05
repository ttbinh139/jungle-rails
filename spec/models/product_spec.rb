require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    before(:each) do
      @category = Category.new(name: "Test Category")
      @category.save!
      @cat_id = @category.id
    end

    it 'all fields should present' do
      @product = Product.new(
        name: "Test product",
        description: "Test desc",
        quantity: 100,
        price_cents: 10000,
        category_id: @cat_id
      )
      @product.save!

      expect(@product.id).to be_present
      expect(@product.name).to be_present
      expect(@product.description).to be_present
      expect(@product.quantity).to be_present
      expect(@product.price_cents).to be_present
      expect(@product.category_id).to be_present
    end

    it 'should invalid when product name is nil' do
      @product = Product.new(
        description: "Test desc",
        quantity: 100,
        price_cents: 10000,
        category_id: @cat_id
      )
      @product.save

      expect(@product.errors.full_messages).to be_present
      expect(@product.errors.full_messages[0]).to eql("Name can't be blank")
    end

    it 'should invalid when product quantity is nil' do
      @product = Product.new(
        name: "Test name",
        description: "Test desc",
        price_cents: 10000,
        category_id: @cat_id
      )
      @product.save

      expect(@product.errors.full_messages).to be_present
      expect(@product.errors.full_messages[0]).to eql("Quantity can't be blank")
    end

    it 'should invalid when product price is nil' do
      @product = Product.new(
        name: "Test name",
        description: "Test desc",
        quantity: 100,
        category_id: @cat_id
      )
      @product.save

      expect(@product.errors.full_messages).to be_present
      expect(@product.errors.full_messages[0]).to eql("Price cents is not a number")
    end
    
    it 'should invalid when product category is nil' do
      @product = Product.new(
        name: "Test name",
        description: "Test desc",
        quantity: 100,
        price_cents: 10000,
      )
      @product.save

      expect(@product.errors.full_messages).to be_present
      expect(@product.errors.full_messages[0]).to eql("Category must exist")
    end

  end
end
