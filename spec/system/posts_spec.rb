require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  context "ポストの作成に成功したとき" do
    it 'そのポスト名を含むフラッシュメッセージが表示される', js: true do
      visit posts_path
      click_link 'mode_edit'
      expect(page).to have_content '新規投稿'
      fill_in "post[name]", with: "ロッキンジャパン"
      fill_in "post[description]", with: "あいみょん見たい"
      fill_in "post[deadline]", with: "2019-09-01"
      fill_in "post[count]", with: "3"
      click_button "commit"
      expect(page).to have_content "ロッキンジャパン"
    end
  end


end
