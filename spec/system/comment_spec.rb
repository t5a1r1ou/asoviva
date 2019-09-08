# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:user_received) { FactoryBot.create(:user, email: 'test_other1@example.com', name: 'Tom') }
  let(:post) { FactoryBot.create(:post, user_id: user_received.id) }

  before do
    sign_in user
    visit post_path(post)
    find("#comments-form_#{post.id}").find('.comment-btn').click
    fill_in 'comment[body]', with: 'なにそれ行きた'
  end

  describe 'コメントしたユーザー' do
    it 'コメントを送るとコメント済みの投稿画面にコメントした投稿とコメントが表示される', js: true do
      expect do
        click_button 'commit'
      end.to change(user.comments, :count).by(1)
      expect(page).to have_content 'リクエストの送信が完了しました'
      expect(page).to have_content 'リクエスト済み'
      visit comments_user_path(user)
      expect(page).to have_content 'なにそれ行きた'
      expect(page).to have_content user_received.name
    end
  end

  describe 'コメントされたユーザー' do
    it 'コメントされると受信したコメント一覧にきたコメントとユーザー名が表示される' do
      expect do
        click_button 'commit'
      end.to change(user.comments, :count).by(1)
      sign_out user
      sign_in user_received
      visit commented_user_path(user_received)
      expect(page).to have_content user.name
      expect(page).to have_content 'なにそれ行きた'
    end
  end
end
