# frozen_string_literal: true

describe 'User API V1 routes', type: :routing do
  include RSpec::Rails::RequestExampleGroup

  let(:sign_up_url) { '/api/v1/guardian' }
  let(:cancel_registration_url) { '/api/v1/guardian' }
  let(:confirm_url) { '/api/v1/guardian' }

  let(:sign_in_url) { '/api/v1/guardian' }
  let(:sign_out_url) { '/api/v1/guardian' }

  let(:forgot_password_url) { '/api/v1/guardian' }

  it { expect(post: sign_up_url).to route_to('devise_token_auth/registrations#create') }
  it { expect(put: sign_up_url).to route_to('devise_token_auth/registrations#update') }
  it { expect(patch: sign_up_url).to route_to('devise_token_auth/registrations#update') }
  it { expect(delete: sign_up_url).to route_to('devise_token_auth/registrations#destroy') }
end
