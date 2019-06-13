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

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { expect(ItemTax.new).to respond_to(:tax_display_text) }
    end

    context 'executes methods correctly' do
      context 'tax_display_text' do
        let!(:item_tax) { create(:item_tax) }

        it 'returns tax value with $ or %' do
          expect(item_tax.tax_display_text).to eq("$#{item_tax.tax}")
        end
      end
    end
  end
end
