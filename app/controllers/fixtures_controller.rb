class FixturesController < ApplicationController
  before_action :load_gw_data, only: %i[ show ]
  before_action :check_parameters, only: %i[ show ]

  TIME_ZONE = 'Asia/Singapore'.freeze

  # GET /fixtures or /fixtures.json
  def index
    @fixtures = all_fixtures
  end

  # GET /fixtures/1 or /fixtures/1.json
  def show
    set_fixture
    @fixture.get_players_stats('opponent', @prev_gw_id)

    redirect_to root_path, notice: @fixture.instance_variable_get(:@error) if @fixture.instance_variable_get(:@error)

    @fixture.get_players_stats('us', @prev_gw_id)
    @total_elements = @fixture.instance_variable_get(:@total_elements)
    @analytics = @fixture.instance_variable_get(:@analytics)
    File.open(Rails.root.join('public', 'result.json'), 'w') { |file| file.write(@fixture.instance_variable_get(:@analytics)) }
  end

  private

  def all_fixtures
    @all_fixtures ||= JSON.load(File.read(Rails.root.join('lib', 'fixtures.json')))
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_fixture
    @fixture_data = all_fixtures.find { |fixture| fixture['gameweek'] == @current_gw_id.to_s}
    all_data = HTTParty.get('https://fantasy.premierleague.com/api/bootstrap-static/')
    @fixture = Fixture.new(@fixture_data, all_data['elements'])
  end

  def load_gw_data
    @gw_details ||= HTTParty.get("https://fantasy.premierleague.com/api/fixtures/?event=#{params[:id]}")
  end

  def is_gw_started?
    load_gw_data[0]['kickoff_time'].to_time.in_time_zone(TIME_ZONE) <= Time.current.in_time_zone(TIME_ZONE)
  end

  # if result = true AND gw Not started: That means no result, redirect
  # if result = true AND gw started: That means result page can show
  # if result = false AND gw Not started: That means current team page can show
  # if result = false AND gw started: That means previous team page can show
  def check_parameters
    @current_gw_id = params[:id]
    @prev_gw_id = params[:id]

    case
    when params[:result].present? && !is_gw_started?
      redirect_to root_path, notice: 'GW Not Started'
    when params[:result].present? && is_gw_started?
      true
    when !params[:result].present? && is_gw_started?
      true
    when !params[:result].present? && !is_gw_started?
      @prev_gw_id = (params[:id].to_i - 1)
    end
  end
end
