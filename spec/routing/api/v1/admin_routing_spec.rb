# frozen_string_literal: true

describe 'User API V1 routes', type: :routing do
  include RSpec::Rails::RequestExampleGroup

  let(:sign_up_url) { '/api/v1/admin' }
  let(:cancel_registration_url) { '/api/v1/admin' }
  let(:confirm_url) { '/api/v1/admin' }

  let(:sign_in_url) { '/api/v1/admin' }
  let(:sign_out_url) { '/api/v1/admin' }

  let(:forgot_password_url) { '/api/v1/admin' }

  it { expect(post: sign_up_url).to route_to('devise_token_auth/registrations#create') }
  it { expect(put: sign_up_url).to route_to('devise_token_auth/registrations#update') }
  it { expect(patch: sign_up_url).to route_to('devise_token_auth/registrations#update') }
  it { expect(delete: sign_up_url).to route_to('devise_token_auth/registrations#destroy') }
end
