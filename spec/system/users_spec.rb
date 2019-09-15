# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'ユーザーの作成' do
    before do
      visit new_user_registration_path
      fill_in 'user[name]', with: 'nakai'
      fill_in 'user[email]', with: 'test@example.com'
    end

    context '有効な値が入力されたとき' do
      it 'プロフィール設定画面に遷移し、フラッシュが表示される', js: true do
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        expect do
          click_button 'commit'
        end.to change(User, :count).by(1)
        expect(page).to have_content 'アカウント登録が完了しました'
        expect(page).to have_css '.user-icon'
        expect(page).to have_content 'プロフィール設定'
        expect(page).to have_content '次にプロフィールを設定してください'
      end
    end

    context '無効な値が入力されたとき' do
      it 'ログイン画面が再度描写され、入力されていたデータが残っている', js: true do
        expect do
          click_button 'commit'
        end.to_not change(User, :count)
        expect(page).to have_content 'パスワードが入力されていません'
        expect(page).to have_xpath("//input[@value='test@example.com']")
      end
    end
  end

  describe 'ユーザーのアカウント設定' do
    before do
      sign_in user
      visit edit_user_registration_path
      fill_in 'user[email]', with: 'new_test@example.com'
    end

    context '有効な値が入力されたとき' do
      it '投稿一覧画面にもどりフラッシュが表示される', js: true do
        fill_in 'user[current_password]', with: user.password
        click_button 'commit'
        expect(page).to have_content 'アカウント情報を変更しました'
        expect(page).to have_content 'mode_edit'
        expect(page).to have_css '.user-icon'
      end
    end

    context '現在のパスワードが入力されなかったとき' do
      it '編集画面が再度描写される', js: true do
        click_button 'commit'
        expect(page).to have_content '現在のパスワードを入力してください'
        expect(page).to have_xpath("//input[@value='new_test@example.com']")
      end
    end
  end

  describe 'ユーザーの削除' do
    it 'トップページにリダイレクトして、フラッシュが表示される', js: true do
      sign_in user
      visit edit_user_registration_path
      click_button 'delete_btn'
      expect(page.driver.browser.switch_to.alert.text).to include 'アカウントを削除します'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております'
      expect(page).to have_css '#start_btn'
      expect(User.count).to eq 0
    end
  end

  describe 'ユーザープロフィールの更新' do
    before do
      sign_in user
      visit edit_user_path(user)
    end

    context '有効な値で登録される時' do
      it 'ユーザー詳細画面に遷移し、フラッシュが表示される', js: true do
        find('.select-wrapper').click
        find('span', text: '男性').click
        fill_in 'user[profile]', with: 'お腹空きました'
        click_button 'commit'
        expect(page).to have_content 'Bobのプロフィールを更新しました!'
        expect(page).to have_content 'お腹空きました'
      end
    end

    context '無効な値で登録しようとした時' do
      it 'プロフィール編集画面に戻り、値は保持されている', js: true do
        fill_in 'user[name]', with: ''
        fill_in 'user[profile]', with: 'Bobです'
        click_button 'commit'
        expect(page).to have_content 'ユーザー名を入力してください'
        expect(page).to have_content 'Bobです'
      end
    end
  end

  describe 'OmniAuthのログイン' do
    context 'twitterでのログイン' do
      before do
        OmniAuth.config.mock_auth[:twitter] = nil
        Rails.application.env_config['omniauth.auth'] = omniauth_user
        visit root_path
      end

      it 'ログインをするとユーザー数が増え、アバターが取得できる', js: true do
        expect do
          click_link 'Twitterではじめる'
        end.to change(User, :count).by(1)
        expect(page).to have_content 'プロフィール設定'
        expect(page).to have_content 'Twitter アカウントによる認証に成功しました'
        user = User.last
        expect(user.avatar.attached?).to eq true
      end
    end

    context 'googleでのログイン' do
      before do
        OmniAuth.config.mock_auth[:google] = nil
        Rails.application.env_config['omniauth.auth'] = omniauth_user :google
        visit root_path
      end

      it 'ログインをするとユーザー数が増え、アバターが取得できる', js: true do
        expect do
          click_link 'Googleではじめる'
        end.to change(User, :count).by(1)
        expect(page).to have_content 'プロフィール設定'
        expect(page).to have_content 'Google アカウントによる認証に成功しました'
        user = User.last
        expect(user.avatar.attached?).to eq true
      end
    end
  end
end
