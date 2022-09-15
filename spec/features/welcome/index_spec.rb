require 'rails_helper'

RSpec.describe 'landing page' do
  describe '#index' do
    it 'displays the title of the application' do
      visit root_path

      expect(page).to have_content("Messages from the Stars")
    end
  end
end