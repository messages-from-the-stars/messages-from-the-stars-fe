require 'rails_helper'

RSpec.describe SatMapMaker do
  
  before :each do
    @sat_lat = 38.9072
    @sat_lng = -77.0369

    @sat_map_maker = SatMapMaker.new(@sat_lat, @sat_lng)
  end

  it 'exists' do
    expect(@sat_map_maker).to be_a SatMapMaker
  end

  it 'returns location parameter string for user' do
    expect(@sat_map_maker.sat_marker_params).to eq("&markers=size:medium|color:red|label:S|#{@sat_lat},#{@sat_lng}")
  end

  it 'returns full url' do
    expect(@sat_map_maker.result_url).to eq("http://maps.googleapis.com/maps/api/staticmap?&zoom=3&size=600x400&style=visibility:on&maptype=hybrid&markers=size:medium|color:red|label:S|38.9072,-77.0369&key=#{ENV['google_maps_key']}")
  end

end