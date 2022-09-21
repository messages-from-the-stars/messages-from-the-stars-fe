require 'rails_helper'

RSpec.describe SatelliteService do
  describe '#get_satellites_in_range' do
    it 'returns a response', :vcr do
      ss = SatelliteService.get_satellites_in_range(39.6431, -104.8987)
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
      expect(response[:passes].first[:startUTC]).to be_a Integer 
    end
  end

  describe '#get_sat_message' do
    it 'returns satellites with messages', :vcr do
      sat_id = 189
      ss = SatelliteService.get_sat_message(sat_id)
      
      sr = ss[:data].first
      expect(ss).to be_a(Hash)

      expect(ss[:data]).to be_a(Array)

      expect(sr[:attributes]).to have_key(:satellite_id)
      expect(sr[:attributes][:satellite_id]).to be_a(Integer)
      expect(sr[:attributes][:satellite_id]).to eq(sat_id)
    end
  end

  describe '#create_satellite' do
    it 'can create a new satellite by norad id', :vcr do
      response = SatelliteService.create_satellite(99999)
       
      expect(response).to be_a(Integer)
    end
  end

  describe '#get_user_satellites' do
    it 'can find all satellites from a user', :vcr do
      results = SatelliteService.get_user_satellites(45)
       
      expect(results).to be_a(Hash)
      expect(results).to have_key(:data)
      expect(results[:data]).to be_a(Array)

      expect(results[:data].first).to have_key(:id)
      expect(results[:data].first[:id]).to be_a(String)

      expect(results[:data].first).to have_key(:type)
      expect(results[:data].first[:type]).to be_a(String)
      expect(results[:data].first[:type]).to eq("satellite")

      expect(results[:data].first).to have_key(:attributes)
      expect(results[:data].first[:attributes]).to be_a(Hash)

      expect(results[:data].first[:attributes]).to have_key(:norad_id)
      expect(results[:data].first[:attributes][:norad_id]).to be_a(Integer)
    end
  end

  describe '#get_norad_id' do
    it 'can find a satellites norad id', :vcr do
      results = SatelliteService.get_norad_id(189)
      
      expect(results).to be_a(Hash)
      expect(results).to have_key(:data)
      expect(results[:data]).to be_a(Hash)

      expect(results[:data]).to have_key(:id)
      expect(results[:data][:id]).to be_a(String)

      expect(results[:data]).to have_key(:type)
      expect(results[:data][:type]).to be_a(String)
      expect(results[:data][:type]).to eq("satellite")

      expect(results[:data]).to have_key(:attributes)
      expect(results[:data][:attributes]).to be_a(Hash)

      expect(results[:data][:attributes]).to have_key(:norad_id)
      expect(results[:data][:attributes][:norad_id]).to be_a(Integer)
    end
  end

  describe '#create_user_sat' do
    it 'can create a user satellite', :vcr do
      results = SatelliteService.create_user_satellite(189, 45)
      
      expect(results).to be_a(Integer)
    end
  end
end