class Fixture
  def initialize(fixture_data, total_elems)
    @gameweek = fixture_data['gameweek']
    @home_teams = fixture_data['home_players']
    @away_teams = fixture_data['away_players']
    @total_elements = total_elems
    @analytics = {}
    @error = nil
  end

  # @params <type: String:['opponent', 'us']>
  def get_players_stats(type, gameweek)
    stats = Statistics.new().instance_variable_get(:@data)
    teams = type == 'us' ? @home_teams : @away_teams

    teams.each do |fpl_id|
      response = HTTParty.get("https://fantasy.premierleague.com/api/entry/#{fpl_id}/event/#{gameweek.to_s}/picks/")
      response['picks'].each do |pick|
        if pick['position'] < 12
          players = [pick['element']]*pick['multiplier']
          stats[:players].push(players)
        else
          stats[:subs].push([pick['element']])
        end
      end

      stats[:points].push(response['entry_history']['total_points'])
      stats[:transfers_made].push(response['entry_history']['event_transfers'])
      stats[:transfers_left].push(response['entry_history']['event_transfers'] == 0 ? 1 : 0)
      stats[:chips_used].push(response['chips_used'])
      stats[:bank].push(response['entry_history']['bank'].to_f/10.0)
    end

    stats.map { |k, v| stats[k].flatten! }
    stats[:players] = stats[:players].tally
    stats[:subs] = stats[:subs].tally
    @analytics[type] = stats
  rescue
    @error = 'This GW data is not available'
  end
end
