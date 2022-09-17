require 'rails_helper'

RSpec.describe DiscoverSatellite do
  describe '#attributes' do
    it 'has attributes' do
      data = {
        'satid': 2435,
        'satname': 'ESSA 3 (TOS-A)',
        'launchDate': '1966-10-02'
      }

      satellite = DiscoverSatellite.new(data)

      expect(satellite).to be_a(DiscoverSatellite)
      expect(satellite.satid).to eq(2435)
      expect(satellite.satname).to eq('ESSA 3 (TOS-A)')
      expect(satellite.launch_date).to eq('1966-10-02')
    end
  end
end