require 'rails_helper'

RSpec.describe SatelliteService do
  describe '#get_satellites_in_range' do
    it 'returns a response' do

      @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)

      allow(SatelliteService).to receive(:get_satellites_in_range).and_return(@found_satellites)

      lat_long = [39.6431, -104.8987]
      ss = SatelliteService.get_satellites_in_range(lat_long)
      sr = ss[:above].first

      expect(ss).to be_a(Hash)
      expect(ss[:above]).to be_a(Array)
      expect(sr).to have_key(:satid)
      expect(sr[:satid]).to be_a(Integer)
      expect(sr).to have_key(:satname)
      expect(sr[:satname]).to be_a(String)
      expect(sr).to have_key(:launchDate)
      expect(sr[:launchDate]).to be_a(String)
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