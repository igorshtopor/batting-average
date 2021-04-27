class Batting

  def initialize(team_name: nil, year: nil, file:)
    @team_name = team_name
    @year = year
    @file = file
    @players = players
  end

  def perform
    result = []

    apply_filters!

    @players.group_by { |p| [p[:playerid], p[:yearid]] }.each do |(id, year), player_records|
      result << {
        id: id,
        yearid: year,
        team: player_records.map { |pr| teams[pr[:teamid]] }.join(','),
        batting_average: batting_average(player_records)
      }
    end

    result.sort { |a, b| b[:batting_average] <=> a[:batting_average] }
  end

  def apply_filters!
    if @team_name && (team_id = teams.find { |_, name| name == @team_name }&.first)
      @players = @players.select { |p| p[:teamid] == team_id }
    end
    @players = @players.select { |p| p[:yearid] == @year.to_i } if @year
  end

  def batting_average(records)
    at_bats = records.map { |r| r[:ab] }.sum
    return 0.0 if at_bats == 0

    (records.map { |r| r[:h] }.sum.to_f / at_bats).round(3)
  end

  def teams
    TeamsWrapper.teams
  end

  def players
    PlayersWrapper.players(@file)
  end
end
