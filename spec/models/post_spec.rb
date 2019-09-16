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
  it { is_expected.to validate_presence_of :category }
  it { is_expected.to validate_numericality_of(:count).only_integer }

  it { is_expected.to validate_length_of(:name).is_at_most(20) }

  it { is_expected.to validate_length_of(:description).is_at_most(140) }

  it { is_expected.to validate_numericality_of(:count).is_less_than_or_equal_to(20) }
  it { is_expected.to validate_numericality_of(:count).is_greater_than(0) }

  describe 'validate date_future' do
    context '今日の日付に設定した場合' do
      it '成功する' do
        post.date = Date.today
        expect(post).to be_valid
      end
    end

    context '昨日の日付に設定した場合' do
      it '失敗する' do
        post.date = Date.today - 1
        expect(post).to_not be_valid
      end
    end
  end

  describe 'category_colorメソッドが正しく実装されている' do
    context 'post.categoryが:eventのとき' do
      it 'returns light-blue lighten-1' do
        post.category = :event
        expect(post.category_color).to eq 'light-blue lighten-1'
      end
    end

    context 'post.categoryが:sightseeingのとき' do
      it 'returns purple lighten-1' do
        post.category = :sightseeing
        expect(post.category_color).to eq 'purple lighten-1'
      end
    end

    context 'post.categoryが:drinkのとき' do
      it 'returns indigo lighten-1' do
        post.category = :drink
        expect(post.category_color).to eq 'indigo lighten-1'
      end
    end

    context 'post.categoryが:lunchのとき' do
      it 'returns teal lighten-1' do
        post.category = :lunch
        expect(post.category_color).to eq 'teal lighten-1'
      end
    end
  end
end
