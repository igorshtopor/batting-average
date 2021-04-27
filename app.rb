require 'sinatra'
require 'json'
require File.expand_path '../lib/wrappers/players_wrapper', __FILE__
require File.expand_path '../lib/wrappers/teams_wrapper', __FILE__
require File.expand_path '../lib/batting', __FILE__

post '/api/v1/batting' do
  content_type 'application/json'
  file = params[:file]&.[](:tempfile)
  return { error: 'Input file missing' }.to_json unless file
  Batting.new(team_name: params[:team_name], year: params[:year], file: file).perform.to_json
end
