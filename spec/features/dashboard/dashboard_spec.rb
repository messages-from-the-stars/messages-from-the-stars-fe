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
        end

        it 'redirects a logged in user to the dashboard' do
            visit '/auth/google_oauth2'
            
            expect(page).to have_content("User Dashboard")
            expect(current_path).to eq("/users/dashboard")
        end 
    end
end  
