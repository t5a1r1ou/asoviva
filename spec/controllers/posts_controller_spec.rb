require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:post) { FactoryBot.create(:post, user_id: user.id) }
  let(:user) { FactoryBot.create(:user) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      sign_in user
      get :show, params: { id: post.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      sign_in user
      get :edit, params: { id: post.id }
      expect(response).to have_http_status(:success)
    end
  end

end
