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
    fill_in 'comment[body]', with: '何それ行きた'
  end

  it 'コメントを送るとコメント済みの画面にコメントした投稿とコメントが表示される', js: true do
    expect do
      click_button 'commit'
    end.to change(user.comments, :count).by(1)
    expect(page).to have_content 'リクエストの送信が完了しました'
    expect(page).to have_content 'リクエスト済み'
    expect(page).to have_content user.name
    expect(page).to have_content '何それ行きた'
  end
end
