# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    name 'ららぽーと横浜'
    description '新作の映画を見たい'
    area 3
    date Date.today + 1
    count 2

    trait :desc_nil do
      name 'テスト'
    end
  end
end
