class Item < ApplicationRecord
  validates :name, :rate, presence: true

  belongs_to :item_category
  has_one :item_tax, dependent: :destroy

  accepts_nested_attributes_for :item_tax

  delegate :name, to: :item_category, prefix: true, allow_nil: true
end
