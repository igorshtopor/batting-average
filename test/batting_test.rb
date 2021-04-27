require File.expand_path '../../lib/batting.rb', __FILE__
require 'minitest/autorun'

class BattingTest < Minitest::Test
  def test_batting_average
    batting = Batting.new(file: File.open('samples/Batting_test.csv')).perform
    assert_equal 2, batting.count
  end

  def test_batting_average_team_filtered
    batting = Batting.new(file: File.open('samples/Batting_test.csv'), team_name: 'Troy Haymakers').perform
    assert_equal 1, batting.count
    assert_equal 0.75, batting.first[:batting_average]
  end

  def test_batting_average_year_filtered
    batting = Batting.new(file: File.open('samples/Batting_test.csv'), year: 1872).perform
    assert_equal 1, batting.count
    assert_equal 0.0, batting.first[:batting_average]
  end

  def test_batting_average_two_stints_in_a_year
    batting = Batting.new(file: File.open('samples/Batting_test.csv'), year: 1871).perform
    assert_equal 1, batting.count
    assert_equal 0.5, batting.first[:batting_average]
  end

  def test_batting_average_year_and_team_filtered
    batting = Batting.new(file: File.open('samples/Batting_test.csv'), year: 1871, team_name: 'New York Mutuals').perform
    assert_equal 1, batting.count
    assert_equal 0.333, batting.first[:batting_average]
  end
end
