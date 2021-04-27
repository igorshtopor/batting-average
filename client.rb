require 'net/http'
require 'json'
require 'terminal-table'
require 'optparse'

options = {}

OptionParser.new do |opts|
  opts.on('-f', '--file FILE', 'File with csv batting data')
  opts.on('-y', '--year YEAR', 'Year for filtering results')
  opts.on('-t', '--team-name TEAM_NAME', 'Team name for filtering results')
end.parse!(into: options)

return puts 'File missing. Use -f file_path.' if options[:file].nil?

url = URI("http://localhost:4567/api/v1/batting")

http = Net::HTTP.new(url.host, url.port)
request = Net::HTTP::Post.new(url)
form_data = [['file', File.open(options[:file])]]
form_data << ['year', options[:year]] if options[:year]
form_data << ['year', options[:team_name]] if options[:team_name]
request.set_form form_data, 'multipart/form-data'
response = http.request(request)
parsed_response = JSON.parse(response.read_body)

puts Terminal::Table.new rows: parsed_response.map(&:values), headings: ['PlayerID', 'yearId','Team name(s)', 'Batting Average']
