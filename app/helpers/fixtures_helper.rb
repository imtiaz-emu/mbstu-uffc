module FixturesHelper
  def players_from_both_teams
    @analytics['us'][:players].keys | @analytics['opponent'][:players].keys
  end

  def subs_from_both_teams
    @analytics['us'][:subs].keys | @analytics['opponent'][:subs].keys
  end

  def get_player_detail(element_id)
    player = @total_elements.find { |element| element['id'] == element_id.to_i }
    player['web_name']
  end

  def opponent_points
    if @live_event_data['elements'].any?
      live_points_for_teams('opponent')
    else
      @analytics['opponent'][:points].sum
    end
  end

  def mbstu_points
    if @live_event_data['elements'].any?
      live_points_for_teams('us')
    else
      @analytics['us'][:points].sum
    end
  end

  def opponent_transfers_left
    @analytics['opponent'][:transfers_left].sum
  end

  def mbstu_transfers_left
    @analytics['us'][:transfers_left].sum
  end

  def opponent_bank
    @analytics['opponent'][:bank].join(', ')
  end

  def mbstu_bank
    @analytics['us'][:bank].join(', ')
  end

  def live_points_for_teams(team)
    sum = 0
    @analytics[team][:players_caps].each do |element_id, no_of_players|
      player = @live_event_data['elements'].find { |element| element['id'] == element_id.to_i }
      sum += (player['stats']['total_points']*no_of_players)
    end
    sum
  end
end
