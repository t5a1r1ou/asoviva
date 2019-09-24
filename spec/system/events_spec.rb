# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe 'イベント検索機能' do
    it 'イベントを検索して、選択したイベントの内容で投稿する', js: true do
      visit events_path
      click_button 'commit'
      expect(page).to have_content 'mode_edit'
      name = find('.card-title', match: :first).text
      find('.edit_btn', match: :first).click
      find('.edit_btn', match: :first)
      expect do
        find('#event_submit').click
      end.to change(Post, :count).by(1)
      expect(page).to have_content name
    end
  end
end
