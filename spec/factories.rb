# frozen_string_literal: true

FactoryBot.define do
  factory :my_model do
    max_limit { 1 }
    submission_date { '2023-10-18' }
  end

  factory :like do
  end

  factory :profile do
  end

  factory :post do
  end

  factory(:user) do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
