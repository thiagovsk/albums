require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:valid_attributes) do
    { username: 'test', password: 'test' }
  end

  let(:invalid_attributes) do
    { username: 'test', password: '12345' }
  end

  before do
    FactoryBot.create(:user, username: 'test', password: 'test', password_confirmation: 'test')
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a session' do
        post login_url, params: { login: valid_attributes }

        expect(session[:user_id]).to be_truthy
      end
    end

    context 'with invalid parameters' do
      it 'not create a session' do
        post login_url, params: { login: invalid_attributes }

        expect(session[:user_id]).to be_falsey
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'with valid parameters' do
      it 'creates a session' do
        delete logout_url

        expect(session[:user_id]).to be_falsey
      end
    end
  end
end
