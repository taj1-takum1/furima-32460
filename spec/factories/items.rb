FactoryBot.define do
  factory :item do
    name {Faker::Games::Pokemon.name}
    description {Faker::Lorem.sentence}
    price {Faker::Number.within(range: 300..9999999)}
    category_id {Faker::Number.within(range: 2..11)}
    rank_id {Faker::Number.within(range: 2..7)}
    delivery_fee_id {Faker::Number.within(range: 2..3)}
    prefecture_id {Faker::Number.within(range: 2..48)}
    delivery_days_id {Faker::Number.within(range: 2..4)}
  
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'),filename: 'test_images.png')
    end
  end
end
