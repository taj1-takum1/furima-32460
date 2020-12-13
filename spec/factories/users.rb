FactoryBot.define do
  factory :user do
    nickname {'sato'}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6, mix_case: true)
    password {password}
    password_confirmation {password}
    last_name {'佐藤'}
    first_name {'太郎'}
    last_furigana {'サトウ'}
    first_furigana {'タロウ'}
    birthday {'1980-01-01'}
  end
end
