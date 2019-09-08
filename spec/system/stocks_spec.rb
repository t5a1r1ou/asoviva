# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stocks', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, email: 'test_other@example.com', name: 'Tom') }
  let!(:post) { FactoryBot.create(:post, user_id: other_user.id) }

  before do
    sign_in user
  end

  describe '投稿一覧画面からの操作' do
    it 'ストックのつけ外しができ、ユーザーの詳細画面でも反映される', js: true do
      visit posts_path
      expect do
        find('.stock-text').click
        find('.stock-text')
      end.to change(user.stocks, :count).by(1)
      visit user_path(user)
      expect(page).to have_content 'ららぽーと横浜'
      visit posts_path
      expect do
        find('.stock-text').click
        find('.stock-text')
      end.to change(user.stocks, :count).by(-1)
      visit user_path(user)
      expect(page).to_not have_content 'ららぽーと横浜'
    end
  end

  describe '投稿詳細画面からの操作' do
    it 'ストックのつけ外しができ、ユーザーの詳細画面でも反映される', js: true do
      visit post_path(post)
      expect do
        find('.stock-text').click
        find('.stock-text')
      end.to change(user.stocks, :count).by(1)
      visit user_path(user)
      expect(page).to have_content 'ららぽーと横浜'
      visit post_path(post)
      expect do
        find('.stock-text').click
        find('.stock-text')
      end.to change(user.stocks, :count).by(-1)
      visit user_path(user)
      expect(page).to_not have_content 'ららぽーと横浜'
    end
  end
end
