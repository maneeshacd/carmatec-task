class ItemTax < ApplicationRecord
  validates :tax, :tax_type, presence: true

  belongs_to :item

  enum tax_type: %i[percentage value]
end
