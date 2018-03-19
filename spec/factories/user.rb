FactoryBot.define do
  factory :user do
    name { Faker::Lorem.word }
    email { Faker::Internet.email }
    password 'test1234'
    confirmed_at Time.zone.now
  end
end
