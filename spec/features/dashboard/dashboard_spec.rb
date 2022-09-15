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
            
            @satellites = JSON.parse(File.read('spec/fixtures/satellites.json'), symbolize_names: true)
            
            allow(SatelliteService).to receive(:get_user_satellites).and_return(@satellites)

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
            save_and_open_page
            within ("#satellites") do 
                expect(page.all('.satellite')[0]).to have_content("128366")
                expect(page.all('.satellite')[1]).to have_content("123456")
            end 
        end 
    end
end  
