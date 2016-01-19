require 'codeclimate-test-reporter'
require 'capybara/rspec'
require 'vcr'

CodeClimate::TestReporter.start
Capybara.javascript_driver = :webkit

VCR.configure do |config|
  config.cassette_library_dir = 'spec/support/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.allow_http_connections_when_no_cassette = true
  config.ignore_hosts 'codeclimate.com'
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # config.before(:each) do
  #   stub_request(:any, /.*facebook.*/)
  #   # stub_request(:post, 'https://api.stripe.com/v1/charges')
  #   stub_request(:get, /.*tumblr.*/).to_return(status: 200,
  #     body: TUMBLR_JSON,
  #     headers: { })
  #   stub_request(:post, /.*stripe.*/).to_return(status: 200,
  #     body: STRIPE_JSON,
  #     headers: { })
  # end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # config.order = :random
end
