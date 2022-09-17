require 'rails_helper'

RSpec.describe SatelliteFacade do
  describe '#above_satellites' do
    it 'returns max ten results from above satellites call' do

      @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)

      allow(SatelliteService).to receive(:get_satellites_in_range).and_return(@found_satellites)

      lat_long = [39.6431, -104.8987]
      results = SatelliteFacade.above_satellites(lat_long)
      
      expect(results.count).to eq(10)
    end
  end
end
