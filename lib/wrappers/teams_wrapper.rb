require 'csv'

class TeamsWrapper
  def self.teams
    @players ||= CSV.parse(File.open('samples/Teams.csv'),
                           headers: true, header_converters: :symbol, converters: [:numeric]).each_with_object({}) do |team, acc|
      acc[team[:teamid]] = team[:name]
    end
  end
end
