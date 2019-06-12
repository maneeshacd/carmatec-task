FactoryBot.define do
  factory :item_tax do
    association :item, factory: :item

    tax_type { Faker::Number.between(0, 1) }
    tax { Faker::Number.decimal(2) }
  end
end
