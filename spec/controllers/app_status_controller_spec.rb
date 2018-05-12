# frozen_string_literal: true

RSpec.describe AppStatusController, type: :controller do
  describe 'GET #health' do
    it 'returns http success' do
      get :health
      expect(response).to have_http_status(:success)
    end

    it 'returns a message in the body' do
      get :health
      expect(response.body).to eq "I'm ok"
    end
  end

  describe 'GET #info' do
    it 'returns http success' do
      get :info
      expect(response).to have_http_status(:success)
    end

    it 'returns a message in the body' do
      get :info
      expect(response.body).to eq 'API info page'
    end
  end
end
