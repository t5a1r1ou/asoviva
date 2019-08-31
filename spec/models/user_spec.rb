require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  let(:user_unsetted_avatar) { FactoryBot.create(:user, email: 'test_user_1@example.com', gender: gender) }

  let(:user_attached_image) { FactoryBot.create(:user, :with_avatar, email: 'test_user_2@example.com') }

  describe "user_iconが期待通り実装されている" do

    context "プロフィール画像が設定されている時" do
      it "user.avatar.attached?がtrueになる" do
        expect(user_attached_image.avatar.attached?).to be true
      end
    end

    context "プロフィール画像が設定されていない時" do

      context "user.jenderが未設定の時" do
        let(:gender) { 0 }
        it "returns 'dammy_not_selected.png'" do
          expect(user_unsetted_avatar.user_icon).to eq 'dammy_not_selected.png'
          expect(user_unsetted_avatar.avatar.attached?).to be false
        end
      end

      context "user.jenderが男性の時" do
        let(:gender) { 1 }
        it "returns 'dammy_man.png'" do
          expect(user_unsetted_avatar.user_icon).to eq 'dammy_man.png'
          expect(user_unsetted_avatar.avatar.attached?).to be false
        end
      end

      context "user.jenderが女性の時" do
        let(:gender) { 2 }
        it "returns 'dammy_woman.png'" do
          expect(user_unsetted_avatar.user_icon).to eq 'dammy_woman.png'
          expect(user_unsetted_avatar.avatar.attached?).to be false
        end
      end
    end
  end
end
