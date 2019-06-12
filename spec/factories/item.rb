FactoryBot.define do
  factory :item do
    association :item_category, factory: :item_category

    name { Faker::Commerce.product_name }
    rate { Faker::Commerce.price }
  end
end
