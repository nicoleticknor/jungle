require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    # before do
      # @category = Category.new(:id => 1, :name => "Apparel")
    # end

    it 'is valid when a name, price, quantity, and category_id are given' do
      @category = Category.new(:id => 1, :name => "Apparel")
      @product = Product.new(:name => "Artificial Skin", :price => 39.99, :quantity => 10, :category => @category)
      expect(@product).to be_valid
    end

    it 'is not valid without a name' do
      @category = Category.new(:id => 1, :name => "Apparel")
      @product = Product.new(:name => nil, :price => 39.99, :quantity => 10, :category => @category)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:name]).to eq(["can't be blank"])
    end

    it 'is not valid without an integer price' do
      @category = Category.new(:id => 1, :name => "Apparel")
      @product = Product.new(:name => "Artificial Skin", :price => nil, :quantity => 10, :category => @category)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price]).to eq(["is not a number", "can't be blank"])
    end

    it 'is not valid without a quantity' do
      @category = Category.new(:id => 1, :name => "Apparel")
      @product = Product.new(:name => "Artificial Skin", :price => 39.99, :quantity => nil, :category => @category)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to eq(["can't be blank"])
    end

    it 'is not valid without a category' do
      @category = Category.new(:id => 1, :name => "Apparel")
      @product = Product.new(:name => "Artificial Skin", :price => 39.99, :quantity => 10, :category => nil)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to eq(["can't be blank"])
    end
  end
end
