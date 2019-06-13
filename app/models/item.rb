class Item < ApplicationRecord
  validates :name, :rate, presence: true

  belongs_to :item_category
  has_one :item_tax, dependent: :destroy

  accepts_nested_attributes_for :item_tax

  delegate :name, to: :item_category, prefix: true, allow_nil: true

  def total_amount
    case item_tax.tax_type
    when 'value'
      rate + item_tax.tax
    when 'percentage'
      ((item_tax.tax / 100.to_f) + 1) * rate
    end
  end
end
