require 'rails_helper'

RSpec.describe ' SatelliteFacade' do
  it 'returns visible times when a satellite passes overhead', :vcr do
     sat_visibility =  SatelliteFacade.get_satellite_visibility(39847, 39.6431, -104.8987)

    expect(sat_visibility).to be_a(Array)
    expect(sat_visibility).to be_all(SatelliteVisibility)
  end
end