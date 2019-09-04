FactoryBot.define do
  factory :user do
    name 'Bob'
    email 'test@example.com'
    password 'password'
    password_confirmation 'password'
    gender 0
    area 4

    trait :with_avatar do
      avatar { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test_man.png'))
      }
    end

    trait :with_too_large_avatar do
      avatar {
        fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'over_10mb.jpg'))
      }
    end

    trait :with_not_image do
      avatar {
        fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test.txt'))
      }
    end

    trait :signed_in_with_twitter do
      image_url {
        Rails.root.join('spec', 'support', 'assets', 'test_man1.png')
      }
    end
  end
end
