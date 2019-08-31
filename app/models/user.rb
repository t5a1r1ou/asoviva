class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :gender, presence: true
  validates :area, presence: true
  validates :profile, length: { maximum: 140 }

  has_one_attached :avatar

  has_many :posts

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
      avatar.variant(combine_options:{resize:"200x200^",crop:"200x200+0+0",gravity: :center}).processed
    else
      case gender
      when '設定しない' then 'dammy_not_selected.png'
      when '男性' then 'dammy_man.png'
      when '女性' then 'dammy_woman.png'
      end
    end
  end

end
