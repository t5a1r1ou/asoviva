require 'rails_helper'

RSpec.describe Post, type: :model do
  context "名称、場所が入力されている時" do
    it "新規登録は成功する" do
      post = Post.new(
        name: "テストイベント",
        area: 3
      )
      expect(post).to be_valid
    end
  end
  context "名称、場所が入力されていない時" do
    context "名称が入力されいない時" do
      it "新規登録は失敗する" do
        post = Post.new(
          name: nil,
          area: 3
        )
        post.valid?
        expect(post.errors[:name]).to include('を入力してください')
      end
    end
    context "場所が入力されていない時" do
      it "新規登録は失敗する" do
        post = Post.new(
          name: "テストイベント",
          area: nil
        )
        post.valid?
        expect(post.errors[:area]).to include('を入力してください')
      end
    end
  end

end
