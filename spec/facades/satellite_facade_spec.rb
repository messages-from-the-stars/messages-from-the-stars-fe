require 'rails_helper'

RSpec.describe SatelliteFacade do
  describe '#above_satellites' do
    it 'returns max ten results from above satellites call' do

      @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)

      allow(SatelliteService).to receive(:get_satellites_in_range).and_return(@found_satellites)

      results = SatelliteFacade.above_satellites(39.6431, -104.8987)
      
      expect(results.count).to eq(10)
    end

    it 'returns visible times when a satellite passes overhead', :vcr do
        sat_visibility =  SatelliteFacade.get_satellite_visibility(39847, 39.6431, -104.8987)

        expect(sat_visibility).to be_a(Array)
        expect(sat_visibility).to be_all(SatelliteVisibility)
    end

    xit 'returns visible times when a satellite passes overhead', :vcr do
        satellites =  SatelliteService.get_user_satellites("123")

        expect(satellites).to be_a(Array)
        expect(satellites).to be_all(Satellite)
    end
  end

  describe '#get_messages' do
    it 'returns satellites with messages' do

      @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)
      allow(SatelliteService).to receive(:get_satellites_in_range).and_return(@found_satellites)

      @found_messages = JSON.parse(File.read('spec/fixtures/message.json'), symbolize_names: true)
      allow(SatelliteService).to receive(:get_sat_message).and_return(@found_messages)

      results = SatelliteFacade.get_sat_message_id(13002)
      expect(results).to be_a(Array)
      expect(results[1]).to be_a(SatelliteMessage)
    end
  end
end
