class Item < ApplicationRecord
  validates :name, :rate, presence: true

  belongs_to :item_category
  has_one :item_tax, dependent: :destroy

  delegate :name, to: :item_category, prefix: true, allow_nil: true
end
