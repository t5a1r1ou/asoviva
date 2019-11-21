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
  end

  context '15文字以内でコメントが送られた時', js: true do
    it 'コメントを送るとコメント済みの画面にコメントした投稿とコメントが表示される' do
      fill_in 'comment[body]', with: '何それ行きた'
      expect do
        click_button 'commit'
      end.to change(user.comments, :count).by(1)
      expect(page).to have_content 'リクエストの送信が完了しました'
      expect(page).to have_content 'リクエスト済み'
      expect(page).to have_content user.name
      expect(page).to have_content '何それ行きた'
    end
  end

  context '15文字より多い文字数のコメントが送られた時', js: true do
    it 'コメントを送ると元の画面がレンダリングされ、アラートが表示される' do
      fill_in 'comment[body]', with: '何何何何何何何何何何何何何何何何'
      expect do
        click_button 'commit'
      end.not_to change(user.comments, :count)
      expect(page).to have_content 'コメントは15文字以内で入力してください'
      expect(page).to have_content post.name
    end
  end
end
