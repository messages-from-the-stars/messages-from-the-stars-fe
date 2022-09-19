require 'rails_helper'

RSpec.describe MapMaker do
  
  before :each do
    @user_lat = 39.7392
    @user_lng = -104.9903
    @sat_lat = 38.9072
    @sat_lng = -77.0369
    @message_start_lat = 51.507
    @message_start_lng = 0.127

    @map_maker = MapMaker.new(@user_lat,@user_lng,@sat_lat,@sat_lng,@message_start_lat, @message_start_lng)
  end

  it 'exists' do
    expect(@map_maker).to be_a MapMaker
  end

  it 'returns location parameter string for user' do
    expect(@map_maker.user_marker_params).to eq("&markers=size:medium|color:blue|label:U|#{@user_lat},#{@user_lng}")
  end

  it 'returns full url' do
    expect(@map_maker.result_url).to eq("http://maps.googleapis.com/maps/api/staticmap?&size=600x400&style=visibility:on&maptype=satellite&markers=size:medium|color:blue|label:U|39.7392,-104.9903&markers=size:medium|color:red|label:S|38.9072,-77.0369&markers=size:medium|color:green|label:M|51.507,0.127&key=#{ENV['google_maps_key']}")
  end

end