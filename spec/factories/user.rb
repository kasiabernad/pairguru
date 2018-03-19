FactoryBot.define do
  factory :user do
    name { Faker::Lorem.word }
    email { Faker::Internet.email }
    password 'test1234'
    confirmed_at Time.zone.now
    
    trait :with_comment do
      transient do
        movie nil
      end
      after(:create) do |user, evaluator|
        create :comment, user: user, movie: evaluator.movie
      end
    end
  end
end
