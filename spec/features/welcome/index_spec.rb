require 'rails_helper'

RSpec.describe 'landing page' do
  describe '#index' do
    it 'displays the title of the application' do

      visit root_path

      expect(page).to have_content("Messages from the Stars")
      expect(page).to have_content("Catch a satellite")
      expect(page).to have_content("Create a message")
      expect(page).to have_content("Cast your message into the cosmic ocean")
      expect(page).to have_content("Log in via Google to begin exploring the skies")
    end
  end
end