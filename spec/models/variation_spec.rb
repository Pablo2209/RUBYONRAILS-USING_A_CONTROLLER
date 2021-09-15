require 'rails_helper'

RSpec.describe Variation, type: :model do
  context 'Validation Test' do
    it 'is not valid with empty attributes' do
      expect(Variation.new).to_not be_valid
    end

    it 'is not valid with a blank name' do
      expect(Variation.new(name: "")).to_not be_valid
    end

  end
end
