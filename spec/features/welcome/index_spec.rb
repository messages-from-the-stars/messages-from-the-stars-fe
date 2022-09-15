require 'rails_helper'

RSpec.describe 'landing page' do
  describe '#index' do
    it 'displays the title of the application and description body' do

      visit root_path

      expect(page).to have_content("Messages from the Stars")
      expect(page).to have_content("Catch a satellite")
      expect(page).to have_content("Create a message")
      expect(page).to have_content("Cast your message into the cosmic ocean")
      expect(page).to have_content("Log in via Google to begin exploring the skies")
    end
  end

  describe '#happy path' do
    it 'has button to log in user, click button to authorize log in via Google' do
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

      visit root_path

      expect(page).to have_link('Log In')

      click_link('Log In')

      expect(current_path).to eq(dashboard_users_path)
    end
  end

  describe '#sad_path' do
    it 'Displays Invalid credentials if log in fails' do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] =     OmniAuth::AuthHash.new(
        {"provider" => "google_oauth2",
          "uid" => "10000000000000000",
          "info" => {
            "name" => "John Smith",
            "email" => "john@example.com",
            "first_name" => "John",
            "last_name" => "Smith",
          },
          "credentials" => {
            "token" => "",
          },
        })

      visit root_path

      click_link('Log In')

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Invalid Credentials')
    end
  end
end