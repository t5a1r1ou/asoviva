class Post < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :area, presence: true
  validates :description, length: { maximum: 140 }
  enum area: {
    '北海道' => 0,
    '東北' => 1,
    '関東' => 2,
    '中部' => 3,
    '近畿' => 4,
    '中国' => 5,
    '四国' => 6,
    '九州' => 7,
    '沖縄' => 8
  }
end
