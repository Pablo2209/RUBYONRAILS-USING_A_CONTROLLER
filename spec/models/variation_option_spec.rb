require 'rails_helper'

RSpec.describe VariationOption, type: :model do
  context 'Validation Test' do
    it 'is not valid with empty attributes' do
      expect(Product.new).to_not be_valid
    end

    it 'is not valid with a blank name' do
      expect(Product.new(name: "", description: "Test", price: 100)).to_not be_valid
    end

    it 'is not valid with a blank description' do
      expect(Product.new(name: "Test", description: "", price: 100)).to_not be_valid
    end

    it 'is not valid without a price' do
      expect(Product.new(name: "", description: "")).to_not be_valid
    end

  end
end
