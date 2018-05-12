# frozen_string_literal: true

describe 'User API V1 routes', type: :routing do
  include RSpec::Rails::RequestExampleGroup

  let(:sign_up_url) { '/api/v1/user' }
  let(:cancel_registration_url) { '/api/v1/user' }
  let(:confirm_url) { '/api/v1/user' }

  let(:sign_in_url) { '/api/v1/user' }
  let(:sign_out_url) { '/api/v1/user' }

  let(:forgot_password_url) { '/api/v1/user' }

  it { expect(post: sign_up_url).to route_to('devise_token_auth/registrations#create') }
  it { expect(put: sign_up_url).to route_to('devise_token_auth/registrations#update') }
  it { expect(patch: sign_up_url).to route_to('devise_token_auth/registrations#update') }
  it { expect(delete: sign_up_url).to route_to('devise_token_auth/registrations#destroy') }
end
