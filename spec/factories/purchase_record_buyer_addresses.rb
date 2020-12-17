FactoryBot.define do
  factory :purchase_record_buyer_address do
    token {"tok_abcdefghijk00000000000000000"}
    postal_code {"123-4567"}
    prefecture_id {2}
    city {"札幌市"}
    house_number {'1-1'}
    building_name {'東京ハイツ'}
    phone_number {'09034432345'}

    # association :user
    # association :item
  end
end
