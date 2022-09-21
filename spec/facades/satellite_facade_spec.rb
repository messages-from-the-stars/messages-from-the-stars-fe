require 'rails_helper'

RSpec.describe SatelliteFacade do
    it 'returns max ten results from above satellites call', :vcr do
      results = SatelliteFacade.above_satellites(39.6431, -104.8987)
      
      expect(results.count).to eq(10)
      expect(results).to be_a(Array)
      expect(results).to be_all(DiscoverSatellite)
    end

    it 'returns visible times when a satellite passes overhead', :vcr do
        sat_visibility = SatelliteFacade.get_satellite_visibility(39847, 39.6431, -104.8987)

        expect(sat_visibility).to be_a(Array)
        expect(sat_visibility).to be_all(SatelliteVisibility)
    end

    it 'returns visible times when a satellite passes overhead', :vcr do
        satellites =  SatelliteFacade.get_user_satellites(45)
         
        expect(satellites).to be_a(Array)
        expect(satellites).to be_all(Satellite)
    end

    it 'returns satellites with messages', :vcr do
      results = SatelliteFacade.get_sat_message_id(189)

      expect(results).to be_a(Array)
      expect(results).to be_all(SatelliteMessage)
    end

    it 'returns norad_id', :vcr do
      results = SatelliteFacade.get_norad_id(189)
       
      expect(results).to be_a(Hash)
      expect(results[:data]).to be_a(Hash)
      expect(results[:data][:attributes]).to be_a(Hash)
    end

    it 'returns satellite position', :vcr do
      results = SatelliteFacade.get_satellite_position(22195)
      
      expect(results).to be_a(SatellitePosition)
    end
end
