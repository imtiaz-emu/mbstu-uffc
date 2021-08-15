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
    @analytics['opponent'][:points].sum
  end

  def mbstu_points
    @analytics['us'][:points].sum
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
end
