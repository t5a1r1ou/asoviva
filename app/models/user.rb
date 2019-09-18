# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: %i[google twitter]

  validates :gender, presence: true
  validates :area, presence: true
  validates :profile, length: { maximum: 140 }
  validates :name, presence: true, length: { maximum: 8 }

  validate :validate_avatar

  has_one_attached :avatar

  has_many :posts, dependent: :destroy

  has_many :stocks, dependent: :destroy
  has_many :stocking_posts, through: :stocks, source: :post

  has_many :relationships, foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :follower

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :following

  has_many :comments, dependent: :destroy
  has_many :sent_comment_posts, through: :comments, source: :post

  enum gender: {
    default: 0,
    men: 1,
    women: 2
  }

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

  def user_icon
    if avatar.attached?
      avatar.variant(combine_options: { resize: '200x200^', crop: '200x200+0+0', gravity: :center }).processed
    else
      case gender_i18n
      when '設定しない' then 'dammy_not_selected.png'
      when '男性' then 'dammy_man.png'
      when '女性' then 'dammy_woman.png'
      end
    end
  end

  def followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end

  def mutual_followers
    followings.with_attached_avatar.select { |follow| followed_by?(follow) }
  end

  def attached_posts(posts)
    posts.with_attached_image
  end

  def attached_users(users)
    users.with_attached_avatar
  end

  def attached_user_posts(posts)
    posts.includes(user: { avatar_attachment: :blob }).with_attached_image
  end

  protected

  class << self
    def find_for_oauth(auth)
      provider = auth[:provider]
      uid = auth[:uid]
      user_name = auth[:info][:name]
      image_url = auth[:info][:image]
      uri = URI.parse(image_url)
      image = uri.open
      email = User.dummy_email(auth)
      password = Devise.friendly_token[0, 20]

      find_or_create_by(provider: provider, uid: uid) do |user|
        user.name = user_name
        user.email = email
        user.password = password
        user.avatar.attach(io: image, filename: "#{user.name}_avatar.png")
      end
    end
  end

  def validate_avatar
    return unless avatar.attached?

    if avatar.blob.byte_size > 10.megabytes
      avatar.purge
      errors.add(:avatar, 'ファイルのサイズが大きすぎます')
    elsif !image?
      avatar.purge
      errors.add(:avatar, 'ファイルが対応している画像データではありません')
    end
  end

  private

  class << self
    def dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
  end

  def image?
    %w[image/jpg image/jpeg image/gif image/png].include?(avatar.blob.content_type)
  end
end
