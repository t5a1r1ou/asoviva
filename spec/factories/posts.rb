require 'date'

FactoryBot.define do
  factory :post do
    name "My Event"
    description "My Description"
    area 3
    count 1
    deadline Date.today
  end
end
