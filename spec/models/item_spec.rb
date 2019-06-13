require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Associations' do
    it { should belong_to(:item_category) }
    it { should have_one(:item_tax).dependent(:destroy) }
  end

  describe 'Validations' do
    subject { create(:item) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:rate) }
    it { should delegate_method(:name).to(:item_category).with_prefix(true) }
  end
end
