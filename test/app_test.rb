require File.expand_path '../../app.rb', __FILE__
require 'minitest/autorun'
require 'rack/test'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_api_v1_batting_content_type
    post '/api/v1/batting', file: Rack::Test::UploadedFile.new('samples/Batting_test.csv')
    assert_match 'application/json', last_response.content_type
  end

  def test_api_v1_batting_file_missing
    post '/api/v1/batting'
    assert_match 'Input file missing', last_response.body
  end
end
