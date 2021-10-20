class FixturesController < ApplicationController
  include FixturesSupport

  # GET /fixtures or /fixtures.json
  def index
    @fixtures = all_fixtures
  end
end
