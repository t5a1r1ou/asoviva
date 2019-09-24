# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET #show' do
    it 'returns http success' do
      sign_in user
      get :show
      expect(response).to have_http_status(:success)
    end
  end
end
