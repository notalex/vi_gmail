$LOAD_PATH << File.expand_path('../../lib', __FILE__)
ENV['VI_GMAIL_ENV'] = 'test'

require 'vi_gmail'
require 'minitest/autorun'
require 'mocha/mini_test'
require 'database_cleaner'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
end

class MiniTest::Spec
  before do
    DatabaseCleaner.start
  end

  after do
    DatabaseCleaner.clean
  end
end
