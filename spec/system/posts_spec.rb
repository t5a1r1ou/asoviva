# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user_id: user.id) }

  before do
    sign_in user
  end

  describe 'ポストの作成' do
    context '成功したとき' do
      it '一覧画面に戻り、そのポスト名を含むフラッシュメッセージが表示される', js: true do
        visit posts_path
        click_link 'mode_edit'
        expect(page).to have_content '新規登録'
        fill_in 'post[name]', with: 'ロッキンジャパン'
        fill_in 'post[description]', with: 'あいみょん見たい'
        fill_in 'post[deadline]', with: Date.today
        fill_in 'post[count]', with: '3'
        click_button 'commit'
        expect(page).to have_content 'ロッキンジャパンに行く予定を登録しました！'
        expect(page).to have_content 'mode_edit'
      end
    end

    context '失敗したとき' do
      it '一覧画面に戻り、エラーメッセージが表示され、入力途中の内容がフォームに保持される', js: true do
        visit posts_path
        click_link 'mode_edit'
        expect(page).to have_content '新規登録'
        fill_in 'post[description]', with: 'あいみょん見たい'
        fill_in 'post[deadline]', with: Date.today
        fill_in 'post[count]', with: '3'
        click_button 'commit'
        expect(page).to have_content 'mode_edit'
        expect(page).to have_content 'どこ行きたい？を入力してください'
        expect(page).to have_content 'エリア、カテゴリが初期化されています。ご注意ください'
        click_link 'mode_edit'
        expect(page).to have_content 'あいみょん見たい'
      end
    end
  end

  describe 'ポストの更新' do
    context '成功したとき' do
      it '一覧画面に戻り、そのポスト名を含むフラッシュメッセージが表示される', js: true do
        visit post_path(post)
        click_link '編集する'
        fill_in 'post[name]', with: 'ロッキンジャパン'
        click_button 'commit'
        expect(page).to have_content 'ロッキンジャパンに行く予定を更新しました！'
        expect(page).to have_content 'mode_edit'
      end
    end

    context '失敗したとき' do
      it '編集画面に戻り、入力途中の内容がフォームに保持される', js: true do
        visit post_path(post)
        click_link '編集する'
        fill_in 'post[name]', with: ''
        click_button 'commit'
        expect(page).to have_content 'どこ行きたい？を入力してください'
        expect(page).to have_content 'エリア、カテゴリが初期化されています。ご注意ください'
        expect(page).to have_content '新作の映画を見たい'
      end
    end
  end

  describe 'ポストの削除' do
    it '一覧画面が表示され、一覧からは削除したポストが消えている', js: true do
      visit posts_path
      expect(page).to have_content 'ららぽーと横浜'
      visit post_path(post)
      click_link '削除する'
      expect(page.driver.browser.switch_to.alert.text).to include 'ららぽーと横浜に行く予定を削除します'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'ららぽーと横浜に行く予定を削除しました'
      expect(page).to have_content 'mode_edit'
    end
  end
end
