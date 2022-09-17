require 'rails_helper'

RSpec.describe SatelliteService do
  describe '#get_satellites_in_range' do
    it 'returns a response' do

      lat_long = [39.6431, -104.8987]
      ss = SatelliteService.get_satellites_in_range(lat_long)
      # sr = ss[:results].first
      expect(ss).to be_a(Hash)
    end
  end

  describe '#get_satellite_visibility' do
    it 'returns when a satellite will be visible in a specific area', :vcr do
      response = SatelliteService.get_satellite_visibility(39847, 39.6431, -104.8987)

      expect(response).to be_a Hash
      expect(response[:passes]).to be_an Array
      expect(response[:passes].first[:startUTC])
      .to be_a Integer 
    end
  end
end