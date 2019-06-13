FactoryBot.define do
  factory :item_tax do
    association :item, factory: :item

    tax_type { 'value' }
    tax { Faker::Number.decimal(2) }
  end
end
