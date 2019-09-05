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

  enum gender: {
    '設定しない' => 0,
    '男性' => 1,
    '女性' => 2
  }

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

  def user_icon
    if avatar.attached?
      avatar.variant(combine_options: { resize: '200x200^', crop: '200x200+0+0', gravity: :center }).processed
    else
      case gender
      when '設定しない' then 'dammy_not_selected.png'
      when '男性' then 'dammy_man.png'
      when '女性' then 'dammy_woman.png'
      end
    end
  end

  def update_and_check_image(update_params)
    if image_url && !avatar.attached?
      uri = URI.parse(image_url)
      file = uri.open
      avatar.attach(io: file, filename: "#{name}_profile.png")
    end
    update(update_params)
  end

  protected

  class << self
    def find_for_oauth(auth)
      provider = auth[:provider]
      uid = auth[:uid]
      user_name = auth[:info][:name]
      image_url = auth[:info][:image]
      email = User.dummy_email(auth)
      password = Devise.friendly_token[0, 20]

      find_or_create_by(provider: provider, uid: uid) do |user|
        user.name = user_name
        user.email = email
        user.password = password
        user.image_url = image_url if provider == 'twitter'
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
