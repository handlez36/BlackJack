FactoryGirl.define do
  factory :game do
    current_bet 0.00
  end
end

FactoryGirl.define do
  factory :card do
    color       1
    suit        2
    raw_value   10
    association :user
    association :deck
  end
end

FactoryGirl.define do
  factory :deck do
  end
end

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "testemail#{n}@email.com"
    end
    password '1234abcd'
    password_confirmation '1234abcd'
    association :game
  end
end
