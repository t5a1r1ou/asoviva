require 'rails_helper'

RSpec.describe 'Users for devise', type: :system do
  let(:user) { FactoryBot.create(:user) }
  describe "ユーザーの作成" do

    context '成功したとき' do
      it "プロフィール設定画面に遷移し、フラッシュが表示される", js: true do
        visit new_user_registration_path
        fill_in 'user[name]', with: "nakai"
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        fill_in 'user[password_confirmation]', with: "password"
        click_button 'commit'
        expect(page).to have_content "アカウント登録が完了しました"
        expect(page).to have_css ".user-icon"
        expect(page).to have_content "プロフィール設定"
        expect(page).to have_content "次にプロフィールを設定してください"
      end
    end

    context '失敗したとき' do
      it "ログイン画面が再度描写され、入力されていたデータが残っている", js: true do
        visit new_user_registration_path
        fill_in 'user[name]', with: "nakai"
        fill_in 'user[email]', with: "test@example.com"
        click_button 'commit'
        expect(page).to have_content "パスワードが入力されていません"
        expect(page).to have_xpath("//input[@value='test@example.com']")
      end
    end
  end

  describe "ユーザーのアカウント設定" do

    context '成功したとき' do
      it "投稿一覧画面にもどりフラッシュが表示される", js: true do
        sign_in user
        visit edit_user_registration_path
        fill_in 'user[name]', with: "nakai"
        fill_in 'user[current_password]', with: user.password
        click_button 'commit'
        expect(page).to have_content "アカウント情報を変更しました"
        expect(page).to have_content "mode_edit"
        expect(page).to have_css ".user-icon"
      end
    end

      context '失敗したとき' do
        it "編集画面が再度描写され、", js: true do
          sign_in user
          visit edit_user_registration_path
          fill_in 'user[name]', with: "nakai"
          click_button 'commit'
          expect(page).to have_content "現在のパスワードを入力してください"
          expect(page).to have_xpath("//input[@value='nakai']")
        end
      end
    end

    describe "ユーザーの削除" do
      it "トップページにリダイレクトして、フラッシュが表示される", js: true do
        sign_in user
        visit edit_user_registration_path
        click_button 'delete_btn'
        expect(page.driver.browser.switch_to.alert.text).to include "アカウントを削除します"
        page.driver.browser.switch_to.alert.accept
        expect(page.driver.browser.switch_to.alert.text).to include "アカウントを削除します"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております"
        expect(page).to have_css "#start_btn"
      end
    end
  end
