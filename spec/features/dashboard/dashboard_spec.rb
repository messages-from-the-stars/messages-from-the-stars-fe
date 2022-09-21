require 'rails_helper'

RSpec.describe 'Dashboard page' do
    context '#happypath' do
        before(:each) do
            OmniAuth.config.test_mode = true
            OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
            {"provider" => "google_oauth2",
                "uid" => "10000000000000000",
                "info" => {
                "name" => "John Smith",
                "email" => "john@example.com",
                "first_name" => "John",
                "last_name" => "Smith",
                },
                "credentials" => {
                "token" => "Token",
                },
            })
            
            @found_satellites = JSON.parse(File.read('spec/fixtures/above_satellites.json'), symbolize_names: true)
            @user = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
            @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
            @visible_sat_times = JSON.parse(File.read('spec/fixtures/satellite_visibility.json'), symbolize_names: true)
            @weather_data = JSON.parse(File.read('spec/fixtures/weather_data.json'), symbolize_names: true)
            @messages = JSON.parse(File.read('spec/fixtures/messages.json'), symbolize_names: true)
            @lat = 39.75
            @long = -104.99
            
            allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)
            allow(SatelliteService).to receive(:get_satellite_visibility).and_return(@visible_sat_times)
            allow(WeatherService).to receive(:get_weather_forecast).and_return(@weather_data)
            allow(UserService).to receive(:find_or_create_user).and_return(@user)
            allow(SatelliteService).to receive(:get_satellites_in_range).and_return(@found_satellites)
            allow(SatelliteService).to receive(:get_sat_message).and_return(@messages)
            allow_any_instance_of(ApplicationController).to receive(:remote_ip).and_return(@lat, @long)

            visit '/auth/google_oauth2'
        end

        it 'redirects a logged in user to the dashboard' do
            visit '/auth/google_oauth2'
            
            expect(page).to have_content("User Dashboard")
            expect(current_path).to eq("/users/dashboard")
        end 

        it 'shows all satellites associated with a user' do
            visit '/users/dashboard'
            
            expect(page).to have_content("User Dashboard")
            expect(current_path).to eq("/users/dashboard")

            expect(page).to have_content("Your Satellites")

            within ("#satellites") do 
                expect(page.all('.satellite')[0]).to have_content("128366")
                expect(page.all('.satellite')[1]).to have_content("123456")
            end 
        end 

        # it 'has a link to discover satellites' do
        #     visit '/users/dashboard'
            
        #     expect(page).to have_content("Discover Satellites")

        #     click_on("Discover Satellites")

        #     expect(current_path).to eq("/users/discover")
        # end 

        it 'show when my satellites will be visible in the next 10 days' do
            visit '/users/dashboard'

            within ("#satellites") do 
                expect(page.all('.satellite')[0]).to have_content("128366")
                expect(page.all('.satellite')[0]).to have_content("Visibility in the next 7 days")
                expect(page.all('.satellite')[0]).to have_content("Sep 16, at 5:41 PM")
                expect(page.all('.satellite')[0]).to have_content("Sep 16, at 7:23 PM")
                expect(page.all('.satellite')[0]).to have_content("Sep 17, at 6:47 PM")
                expect(page.all('.satellite')[0]).to have_content("Sep 17, at 8:30 PM")
            end
        end 

        it 'shows the weather for each' do
            visit '/users/dashboard'
           
            within ("#satellites") do 
                expect(page.all('.satellite')[0]).to have_content("Visibility in the next 7 days")
                expect(page.all('.satellite')[0]).to have_content("Sep 16, at 5:41 PM")
                expect(page.all('.satellite')[0]).to have_content("Weather: Clear")
                expect(page.all('.satellite')[0]).to have_content("Sep 16, at 7:23 PM")
                expect(page.all('.satellite')[0]).to have_content("Weather: Clear")
                expect(page.all('.satellite')[0]).to have_content("Sep 17, at 6:47 PM")
                expect(page.all('.satellite')[0]).to have_content("Weather: Clouds")
                expect(page.all('.satellite')[0]).to have_content("Sep 17, at 8:30 PM")
                expect(page.all('.satellite')[0]).to have_content("Weather: Clouds")
            end
        end 
    end

     context '#sadpath' do
        it 'redirects a non-logged in user to the landing page' do
            visit '/users/dashboard'
            
            expect(current_path).to eq("/")
        end
     end 
end  
