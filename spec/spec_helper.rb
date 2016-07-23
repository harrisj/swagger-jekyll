require 'jekyll'
require_relative '../lib/swagger_jekyll'

ENV['RACK_ENV'] ||= 'test'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order = :random
end
