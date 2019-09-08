# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Follows', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user, email: 'test_other1@example.com', name: 'Tom') }

  before do
    sign_in user
  end

  describe 'ユーザー一覧画面からの操作' do
    it 'フォローのつけ外しができる', js: true do
      visit users_path
      expect do
        find('.btn_follow').click
        find('.btn_follow')
      end.to change(user.followings, 'count').by(1)
      expect do
        find('.btn_follow').click
        find('.btn_follow')
      end.to change(user.followings, 'count').by(-1)
    end
  end

  describe 'ユーザー詳細画面からの操作' do
    it 'フォローのつけ外しができる', js: true do
      visit user_path(other_user)
      expect do
        find('.btn_follow').click
        find('.btn_follow')
      end.to change(user.followings, 'count').by(1)
      expect do
        find('.btn_follow').click
        find('.btn_follow')
      end.to change(user.followings, 'count').by(-1)
    end
  end
end
