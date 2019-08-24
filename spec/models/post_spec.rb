require 'rails_helper'

RSpec.describe Post, type: :model do

  context "名称、場所、日時が入力されている新規登録" do
    it "成功する" do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :area }
  it { is_expected.to validate_presence_of :deadline }
  it { is_expected.to validate_presence_of :count }

  it { is_expected.to validate_length_of(:name).is_at_most(20) }

  it { is_expected.to validate_length_of(:description).is_at_most(140) }

  it { is_expected.to validate_numericality_of(:count).only_integer }
  it { is_expected.to validate_numericality_of(:count).is_less_than(20) }
  it { is_expected.to validate_numericality_of(:count).allow_nil }

  describe "validate deadline_future" do

    context "今日の日付に設定した場合" do
      it "成功する" do
        expect(FactoryBot.build(:post, deadline: Date.today)).to be_valid
      end
    end

    context "昨日の日付に設定した場合" do
      it "失敗する" do
        expect(FactoryBot.build(:post, deadline: Date.today - 1)).to_not be_valid
      end
    end
  end

  describe "descriptionのコールバック" do

    context "descriptionをnilで登録した時" do
        it "デフォルトの値が入る" do
          post = FactoryBot.create(:post, description: nil)
          expect(post.description).to eq "とりあえず遊びたーい"
        end
    end

    context "descriptionに文字を登録した時" do
      it "入力した値がそのまま入る" do
        post = FactoryBot.create(:post, description: "海で遊びたい")
        expect(post.description).to eq "海で遊びたい"
      end
    end
  end
end
