require 'bundler/setup'
Bundler.setup

require 'swagger_jekyll'

RSpec.configure do |config|
  # some (optional) config here
  def fixture_path(name)
    File.join(File.dirname(__FILE__), 'fixtures', "#{name}.json")
  end
end
