# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.build(:post, user_id: user.id) }
  let(:post_desc_nil) { FactoryBot.create(:post, :desc_nil, user_id: user.id) }
  let!(:user) { FactoryBot.create(:user) }

  context '名称、場所、日時が入力されている新規登録' do
    it '成功する' do
      expect(post).to be_valid
    end
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :area }
  it { is_expected.to validate_presence_of :deadline }
  it { is_expected.to validate_presence_of :category }
  it { is_expected.to validate_numericality_of(:count).only_integer }

  it { is_expected.to validate_length_of(:name).is_at_most(20) }

  it { is_expected.to validate_length_of(:description).is_at_most(140) }

  it { is_expected.to validate_numericality_of(:count).is_less_than_or_equal_to(20) }
  it { is_expected.to validate_numericality_of(:count).is_greater_than(0) }

  describe 'validate deadline_future' do
    context '今日の日付に設定した場合' do
      it '成功する' do
        post.deadline = Date.today
        expect(post).to be_valid
      end
    end

    context '昨日の日付に設定した場合' do
      it '失敗する' do
        post.deadline = Date.today - 1
        expect(post).to_not be_valid
      end
    end
  end

  describe 'count_aboutメソッドが正しく実装されている' do
    context 'post.countが1の時' do
      it '「1人」' do
        post.count = 1
        expect(post.count_about).to eq '1人'
      end
    end

    context 'post.countが2から4の時' do
      context '2の時' do
        it '「2~4人」' do
          post.count = 2
          expect(post.count_about).to eq '2~4人'
        end
      end

      context '4の時' do
        it '「2~4人」' do
          post.count = 4
          expect(post.count_about).to eq '2~4人'
        end
      end
    end

    context 'post.countが5以上の時' do
      it '「ワイワイ」' do
        post.count = 5
        expect(post.count_about).to eq 'ワイワイ'
      end
    end
  end

  describe 'category_colorメソッドが正しく実装されている' do
    context "post.categoryが'イベント'のとき" do
      it 'returns light-blue lighten-1' do
        post.category = 'イベント'
        expect(post.category_color).to eq 'light-blue lighten-1'
      end
    end

    context "post.categoryが'観光'のとき" do
      it 'returns purple lighten-1' do
        post.category = '観光'
        expect(post.category_color).to eq 'purple lighten-1'
      end
    end

    context "post.categoryが'飲み会'のとき" do
      it 'returns indigo lighten-1' do
        post.category = '飲み会'
        expect(post.category_color).to eq 'indigo lighten-1'
      end
    end

    context "post.categoryが'ランチ'のとき" do
      it 'returns teal lighten-1' do
        post.category = 'ランチ'
        expect(post.category_color).to eq 'teal lighten-1'
      end
    end
  end
end
