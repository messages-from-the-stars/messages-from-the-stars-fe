require 'rails_helper'

RSpec.describe SatellitePosition do

  it 'exists' do
    data = {
    "info": {
        "satname": "LAGEOS 2",
        "satid": 22195,
        "transactionscount": 51
    },
    "positions": [
        {
            "satlatitude": -19.59326214,
            "satlongitude": -76.10313081,
            "sataltitude": 5833.65,
            "azimuth": 2.97,
            "elevation": -76.61,
            "ra": 244.50685144,
            "dec": -26.29786845,
            "timestamp": 1663795179,
            "eclipsed": false
        }
    ]
}

    position = SatellitePosition.new(data)

    expect(position).to be_a SatellitePosition
    expect(position.norad_id).to eq(22195)
    expect(position.name).to eq("LAGEOS 2")
    expect(position.sat_lat).to eq(-19.59326214)
    expect(position.sat_lng).to eq(-76.10313081)
  end

end