# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :post_id, presence: true
  validates :user_id, presence: true

  def commented_user
    User.find(self.user_id)
  end
end
