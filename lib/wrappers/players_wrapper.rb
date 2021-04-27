require 'csv'

class PlayersWrapper
  def self.players(file)
    file ||= File.open('samples/Batting.csv')
    @players = CSV.parse(file,
                         headers: true, header_converters: :symbol, converters: [:numeric])
  end
end
