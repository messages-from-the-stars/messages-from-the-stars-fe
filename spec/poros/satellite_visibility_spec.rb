require "rails_helper"

RSpec.describe SatelliteVisibility do
    it "exists" do
        data = {
            startUTC: 1663428357
        }
        sat_id = "12345"
    
        sat_vis = SatelliteVisibility.new(data, sat_id)

        expect(sat_vis).to be_a SatelliteVisibility
        expect(sat_vis.sat_id).to eq("12345")
        expect(sat_vis.starting_time).to eq("Sep 17, at  9:25 AM")
    end 
end 
