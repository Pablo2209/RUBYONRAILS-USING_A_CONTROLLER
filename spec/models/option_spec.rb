require 'rails_helper'

RSpec.describe Option, type: :model do
  context 'Validation Test' do
    it 'is not valid with empty attributes' do
      expect(Option.new).to_not be_valid
    end

    it 'is not valid with a blank name' do
      expect(Option.new(name: "", value: "Test")).to_not be_valid
    end

    it 'is not vali with a blank value' do
      expect(Option.new(name: "Test", value: "")).to_not be_valid
    end
  end

end
