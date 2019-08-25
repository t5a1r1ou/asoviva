require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      post = FactoryBot.create(:post)
      get :show, params: { id: post.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      post = FactoryBot.create(:post)
      get :edit, params: { id: post.id }
      expect(response).to have_http_status(:success)
    end
  end

end
