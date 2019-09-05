# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name 'Bob'
    email 'test@example.com'
    password 'password'
    password_confirmation 'password'
    gender 0
    area 4

    trait :with_avatar do
      avatar do
        fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test_man.png'))
      end
    end

    trait :with_too_large_avatar do
      avatar do
        fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'over_10mb.jpg'))
      end
    end

    trait :with_not_image do
      avatar do
        fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test.txt'))
      end
    end

    trait :signed_in_with_twitter do
      image_url do
        Rails.root.join('spec', 'support', 'assets', 'test_man1.png')
      end
    end
  end
end
