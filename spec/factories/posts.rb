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

    trait :with_image do
      image fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test_man.png'))
    end
  end
end
