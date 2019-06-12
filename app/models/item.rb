class Item < ApplicationRecord
  validates :name, :rate, presence: true

  belongs_to :item_category
  has_one :item_tax, dependent: :destroy
end
