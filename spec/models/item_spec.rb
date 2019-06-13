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
    it { should accept_nested_attributes_for(:item_tax) }
    it { should delegate_method(:name).to(:item_category).with_prefix(true) }
  end

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { expect(Item.new).to respond_to(:total_amount) }
    end

    context 'executes methods correctly' do
      let(:item) { create(:item) }

      context 'total_amount if tax in percentage' do
        it 'returns total amount by calculating tax percentage' do
          item_tax_with_value =
            item.create_item_tax(tax: 100, tax_type: :percentage)
          expect(item.total_amount).to eq(item.rate * 2)
        end
      end

      context 'total_amount if tax in value' do
        it 'returns total amount by calculating tax value' do
          item_tax_with_value =
            item.create_item_tax(tax: 100, tax_type: :value)
          expect(item.total_amount).to eq(item.rate + 100)
        end
      end
    end
  end
end
