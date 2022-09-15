require 'rails_helper'

RSpec.describe 'OAuth Login with Google' do
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

    it 'redirects and creates a new user' do
      visit '/auth/google_oauth2'

      expect(User.last.uid).to eq("10000000000000000")
      expect(User.last.username).to eq("john@example.com")

      expect(current_path).to eq(dashboard_users_path)
    end
  end
end