class BorController < ApplicationController
  include FixturesSupport

  # GET /bor or /bor.json
  def index
    all_fixtures
  end

  private

  def all_fixtures
    @fixtures_ohid ||= JSON.load(File.read(Rails.root.join('lib', 'bor_ohid.json')))
    @fixtures_khaled ||= JSON.load(File.read(Rails.root.join('lib', 'bor_khaled.json')))
  end
end
