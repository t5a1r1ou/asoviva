FactoryBot.define do

  factory :post do
    name "ららぽーと横浜"
    description "新作の映画を見たい"
    area 3
    deadline Date.today + 1
  end
end
