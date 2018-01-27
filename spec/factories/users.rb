FactoryBot.define do
  factory :user do
    first_name 'Tester'
    sequence(:last_name).to_s
    sequence(:email) { |n| "#{n}@example.com" }
    password 'password'
  end
end
