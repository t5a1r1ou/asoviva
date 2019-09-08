# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :post_id }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }
end
