require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'must not have two parents' do
    it 'creates the same category' do
      expect{ 
        Category.create!([{name: "CategoryTest", category_id: nil},
                          {name: "CategoryTest", category_id: nil}])
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'Validation Test' do
    it 'is not valid with empty attributes' do
      expect(Category.new).to_not be_valid
    end

    it 'is not valid a blank name' do
      expect(Category.new(name: "")).to_not be_valid
    end
  end

end
