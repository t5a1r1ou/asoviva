# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'ユーザープロフィールの更新' do
    context '有効な値で登録される時' do
      it 'ユーザー詳細画面に遷移し、フラッシュが表示される', js: true do
        sign_in user
        visit edit_user_path(user)
        find('.select-wrapper').click
        find('span', text: '男性').click
        fill_in 'user[profile]', with: 'お腹空きました'
        click_button 'commit'
        expect(page).to have_content 'Bobのプロフィールを更新しました!'
        expect(page).to have_content 'お腹空きました'
      end
    end

    context '無効な値で登録しようとした時', :focus do
      it 'プロフィール編集画面に戻り、値は保持されている', js: true do
        sign_in user
        visit edit_user_path(user)
        fill_in 'user[name]', with: ''
        fill_in 'user[profile]', with: 'Bobです'
        click_button 'commit'
        expect(page).to have_content 'ユーザー名を入力してください'
        expect(page).to have_content 'Bobです'
      end
    end
  end
end
