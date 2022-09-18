require 'rails_helper'

RSpec.describe MapMaker do
  
  before :each do
    @user_lat = 39.7392
    @user_long = 104.9903
    @sat_lat = 38.9072
    @sat_lng = 77.0369

    @map_maker = MapMaker.new(@user_lat,@user_long,@sat_lat,@sat_lng)
  end

  it 'exists' do
    expect(@map_maker).to be_a MapMaker
  end

  it 'returns location parameter string for user' do
    expect(@map_maker.user_location).to eq()
  end
end