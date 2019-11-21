# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :body, length: { maximum: 15 }

  def commented_user
    User.find(user_id)
  end
end
