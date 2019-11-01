# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }

  describe 'GET #show' do
    it 'returns http success' do
      sign_in user
      get :show, params: { id: post.id }
      expect(response).to have_http_status(:success)
    end
  end
end
