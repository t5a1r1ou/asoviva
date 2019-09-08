# frozen_string_literal: true

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
  validates :user_id, presence: true

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

  belongs_to :user

  has_many :stocks, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :commented_users

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

  def deadline_future
    errors.add(:deadline, 'には今日以降の日付を入力してください') if deadline && deadline < Date.today
  end

  def long_title_class
    'name_long' if name.split(//).size > 8
  end

  def description_digest
    description.truncate(12)
  end

  def stocked_by?(user)
    stocks.where(user_id: user.id).exists?
  end

  def commented_by?(user)
    comments.where(user_id: user.id).exists?
  end
end
