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
  it { is_expected.to validate_numericality_of(:count).only_integer }


  it { is_expected.to validate_length_of(:name).is_at_most(20) }

  it { is_expected.to validate_length_of(:description).is_at_most(140) }

  it { is_expected.to validate_numericality_of(:count).is_less_than_or_equal_to(20) }
  it { is_expected.to validate_numericality_of(:count).is_greater_than(0) }

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

  describe "count_aboutメソッドが正しく実装されている" do
    context "post.countが1の時" do
      it "「1人」" do
        post = FactoryBot.build(:post, count: 1)
        expect(post.count_about).to eq "1人"
      end
    end
    context "post.countが2から4の時" do
      context "2の時" do
        it "「2~4人」" do
          post = FactoryBot.build(:post, count: 2)
          expect(post.count_about).to eq "2~4人"
        end
      end
      context "4の時" do
        it "「2~4人」" do
          post = FactoryBot.build(:post, count: 4)
          expect(post.count_about).to eq "2~4人"
        end
      end
    end
    context "post.countが5以上の時" do
      it "「ワイワイ」" do
        post = FactoryBot.build(:post, count: 5)
        expect(post.count_about).to eq 'ワイワイ'
      end
    end
  end
end
