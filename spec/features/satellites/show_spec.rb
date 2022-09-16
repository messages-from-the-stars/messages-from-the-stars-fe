require 'rails_helper'

RSpec.describe 'Satellite Show Page' do
  context '#happypath' do
    before :each do
      @sat_call = JSON.parse(File.read('spec/fixtures/satellite.json'), symbolize_names: true)
      @sat_id = @sat_call[:info][:satid]
      allow(SatelliteService).to receive(:get_satellite).and_return(@sat_call)
    end 
    
    it 'shows a satellites information' do
      visit "api/v1/satellites/#{@sat_id}"
      
      expect(page).to have_content("NORAD ID: 25544")
      expect(page).to have_content('Satellite Name: SPACE STATION')
    end
  end
end