# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyText" }
    status { 1 }
    priority { 1 }
  end

  factory :blog_post do
    title { "MyString" }
    content { "MyText" }
    author { nil }
    category { nil }
    slug { "MyString" }
    tags { "MyText" }
    featured_image_url { "MyString" }
    status { "MyString" }
    published_at { "2024-02-07 08:32:47" }
  end

  factory :category do
    name { "MyString" }
  end

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
