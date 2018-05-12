# frozen_string_literal: true

describe 'Status routes', type: :routing do
  include RSpec::Rails::RequestExampleGroup

  let(:health_url) { '/status/health' }
  let(:info_url) { '/status/info' }

  it { expect(get: health_url).to route_to('app_status#health') }
  it { expect(get: info_url).to route_to('app_status#info') }
end
