require "rails_helper"

RSpec.describe Satellite do
    it "exists" do
        data = {
            "id": "13002",
            "type": "satellite",
            "attributes": {
                "norad_id": "128366",
                "satname": "Weather"
            }
        }
    
        sat = Satellite.new(data)

        expect(sat).to be_a Satellite
        expect(sat.id).to eq("13002")
        expect(sat.norad_id).to eq("128366")
    end 
end 