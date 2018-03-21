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
    
    trait :with_comments do
      after(:create) do |user|
        create_list :comment, 5, user: user
      end
    end

    trait :with_old_comments do
      after(:create) do |user|
        Timecop.travel(10.days.ago) do
          create_list :comment, 10, user: user
        end
      end
    end
  end
end
