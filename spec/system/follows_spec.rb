# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Follows', type: :system do
  let(:user) { FactoryBot.create(:user, id: 1) }
  let!(:other_user) { FactoryBot.create(:user, email: 'test_other1@example.com', name: 'Tom', id: 2) }
  let!(:sample_user) { FactoryBot.create(:user, email: 'test_other2@example.com', name: 'Jane', id: 3) }

  before do
    sign_in user
  end

  describe 'ユーザー一覧画面からの操作', :focus do
    it 'フォローのつけ外しができる', js: true do
      visit users_path
      expect do
        find('#follow-btn_2', match: :first).find('.btn_follow').click
        find('#follow-btn_2', match: :first).find('.btn_follow')
      end.to change(user.followings, 'count').by(1)
      expect do
        find('#follow-btn_2', match: :first).find('.btn_follow').click
        find('#follow-btn_2', match: :first).find('.btn_follow')
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

  describe 'ユーザー一覧画面のスイッチ機能', :focus do
    it 'スイッチのきりかえが動作する', js: true do
      visit users_path
      find('#follow-btn_2').find('.btn_follow').click
      sign_out user
      sign_in other_user
      visit users_path
      expect(page).to have_content user.name
      expect(page).to have_content other_user.name
      expect(page).to have_content sample_user.name
      find('#follow-btn_3').find('.btn_follow').click
      find('#follows_switch').click
      find('#follows_switch')
      expect(page).to_not have_content user.name
      expect(page).to have_content sample_user.name
      find('#followers_switch').click
      find('#followers_switch')
      expect(page).to_not have_content user.name
      expect(page).to_not have_content sample_user.name
      find('#follows_switch').click
      find('#follows_switch')
      expect(page).to have_content user.name
      expect(page).to_not have_content sample_user.name
    end
  end
end
