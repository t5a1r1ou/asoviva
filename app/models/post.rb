class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  validates :name, presence: true, length: { maximum: 20 }
  validates :area, presence: true
  validates :category, presence: true
  validates :description, length: { maximum: 140 }
  validates :count, numericality: {
    only_integer: true,
    less_than_or_equal_to: 20,
    greater_than: 0
  }
  validates :deadline, presence: true
  validate :deadline_future

  before_validation :set_description_default

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

  enum category: {
    'イベント' => 1,
    '観光' => 2,
    '飲み会' => 3,
    'ランチ' => 4
  }

  def count_about
    case count
    when 1 then '1人'
    when (2..4) then '2~4人'
    else 'ワイワイ'
    end
  end

  def category_color
    case category
    when 'イベント' then 'light-blue lighten-1'
    when '観光' then 'purple lighten-1'
    when '飲み会' then 'indigo lighten-1'
    when 'ランチ' then 'teal lighten-1'
    end
  end

  private

  def deadline_future
    errors.add(:deadline, 'には今日以降の日付を入力してください') if deadline && deadline < Date.today
  end

  def set_description_default
    self.description = 'とりあえず遊びたーい' if description.blank?
  end
end
