# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  let(:user_unsetted_avatar) { FactoryBot.create(:user, email: 'test_user_1@example.com', gender: gender) }

  let(:user_attached_image) { FactoryBot.create(:user, :with_avatar, email: 'test_user_2@example.com') }

  let(:user_too_large_avatar) do
    FactoryBot.build(:user, :with_too_large_avatar)
  end

  let(:user_attached_not_image) { FactoryBot.build(:user, :with_not_image) }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :gender }
  it { is_expected.to validate_presence_of :area }

  it { is_expected.to validate_length_of(:name).is_at_most(8) }

  it { is_expected.to validate_length_of(:profile).is_at_most(140) }

  describe 'user_iconが期待通り実装されている' do
    context 'プロフィール画像が設定されている時' do
      it 'user.avatar.attached?がtrueになる' do
        expect(user_attached_image.avatar.attached?).to be true
      end
    end

    context 'プロフィール画像が設定されていない時' do
      context 'user.genderが未設定の時' do
        let(:gender) { 0 }
        it "returns 'dammy_not_selected.png'" do
          expect(user_unsetted_avatar.user_icon).to eq 'dammy_not_selected.png'
          expect(user_unsetted_avatar.avatar.attached?).to be false
        end
      end

      context 'user.genderが男性の時' do
        let(:gender) { 1 }
        it "returns 'dammy_man.png'" do
          expect(user_unsetted_avatar.user_icon).to eq 'dammy_man.png'
          expect(user_unsetted_avatar.avatar.attached?).to be false
        end
      end

      context 'user.genderが女性の時' do
        let(:gender) { 2 }
        it "returns 'dammy_woman.png'" do
          expect(user_unsetted_avatar.user_icon).to eq 'dammy_woman.png'
          expect(user_unsetted_avatar.avatar.attached?).to be false
        end
      end
    end
  end

  describe 'avatarのバリデーション' do
    context 'ファイルサイズが10MBを越える時' do
      it 'ファイルサイズが大きすぎますというエラーメッセージが返る' do
        user_too_large_avatar.valid?
        expect(user_too_large_avatar.errors[:avatar]).to include 'ファイルのサイズが大きすぎます'
      end
    end

    context 'ファイルの種類がjpeg, jpg, png, gif以外の時' do
      it 'ファイルが対応している画像データではありませんというエラーメッセージが返る' do
        user_attached_not_image.valid?
        expect(user_attached_not_image.errors[:avatar]).to include 'ファイルが対応している画像データではありません'
      end
    end
  end
end
