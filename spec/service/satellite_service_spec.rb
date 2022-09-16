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
end