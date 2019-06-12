require 'rails_helper'

RSpec.describe ItemTax, type: :model do
  describe 'Associations' do
    it { should belong_to(:item) }
  end

  describe 'Validations' do
    subject { create(:item_tax) }

    it { should validate_presence_of(:tax) }
    it { should validate_presence_of(:tax_type) }
  end
end
