FactoryBot.define do
  factory :item_category do
    name { Faker::Commerce.product_name }
  end
end
