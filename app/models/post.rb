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
  validate :date_future
  validates :user_id, presence: true
  validates :image, presence: true

  enum area: {
    hokkaido: 0,
    tohoku: 1,
    kanto: 2,
    koushinetsu: 3,
    tokai: 4,
    hokuriku: 5,
    kansai: 6,
    chugoku: 7,
    shikoku: 8,
    kyushu: 9
  }

  enum category: {
    event: 0,
    sightseeing: 1,
    drink: 2,
    lunch: 3
  }

  belongs_to :user

  has_many :stocks, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :commented_users

  has_one_attached :image

  def category_color
    case category_i18n
    when 'イベント' then 'light-blue lighten-1'
    when '観光' then 'purple lighten-1'
    when '飲み会' then 'indigo lighten-1'
    when 'ランチ' then 'teal lighten-1'
    end
  end

  def date_future
    errors.add(:date, 'には今日以降の日付を入力してください') if date && date < Date.today
  end

  def long_title_class
    'name_long' if name.split(//).size > Settings.post.long_name
  end

  def description_digest
    description.truncate(Settings.post.long_description)
  end

  def stocked_by?(user)
    stocks.where(user_id: user.id).exists?
  end

  def commented_by?(user)
    comments.where(user_id: user.id).exists?
  end

  def commented_by(user)
    comments.where(user_id: user.id)
  end

  def create_ogp
    text =
      count != 1 ? "#{name}に一緒に行く人を#{count - 1}人募集" : "#{name}に行きたい"
    OgpCreator.build(text).tempfile.open
  end
end
