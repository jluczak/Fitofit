FactoryBot.define do
  factory :user, class: User do
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password { 'password' }
  end
end
