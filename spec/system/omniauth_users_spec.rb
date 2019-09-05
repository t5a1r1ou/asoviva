# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users through OmniAuth', type: :system do
  describe 'OmniAuthのログイン' do
    context 'twitterでのログイン' do
      before do
        OmniAuth.config.mock_auth[:twitter] = nil
        Rails.application.env_config['omniauth.auth'] = omniauth_user
        visit root_path
      end

      it 'ログインをするとユーザー数が増え、アバターのurlが取得できる', js: true do
        expect do
          click_link 'Twitterでログイン'
        end.to change(User, :count).by(1)
        expect(page).to have_content 'プロフィール設定'
        expect(page).to have_content 'Twitter アカウントによる認証に成功しました'
        user = User.last
        expect(user.image_url).to eq 'https://test.com/test.png'
      end
    end

    context 'googleでのログイン' do
      before do
        OmniAuth.config.mock_auth[:google] = nil
        Rails.application.env_config['omniauth.auth'] = omniauth_user :google
        visit root_path
      end

      it 'ログインをするとユーザー数が増えるが、アバターのurlは取得できない', js: true do
        expect do
          click_link 'Googleでログイン'
        end.to change(User, :count).by(1)
        expect(page).to have_content 'プロフィール設定'
        expect(page).to have_content 'Google アカウントによる認証に成功しました'
        user = User.last
        expect(user.image_url).to eq nil
      end
    end
  end
end
