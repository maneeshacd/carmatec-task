require 'rails_helper'

RSpec.describe ItemCategory, type: :model do
  describe 'Associations' do
    it { should have_many(:items).dependent(:destroy) }
  end

  describe 'Validations' do
    subject { create(:item_category) }

    it { should validate_presence_of(:name) }
  end
end
