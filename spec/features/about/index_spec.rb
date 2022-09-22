require 'rails_helper'

RSpec.describe 'About Page' do

  before(:each) do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

    visit '/auth/google_oauth2'

    visit '/about'
  end

  it 'has a link to the front-end repository', :vcr do  
    expect(page).to have_link("Front-End Repository")
  end

  it 'has a link to the back-end repository', :vcr do  
    expect(page).to have_link("Back-End Repository")
  end

  it 'has a link to contributors githubs', :vcr do
    within "#contributors" do
      expect(page).to have_link("@tig-o")
      expect(page).to have_link("@philmarcu")
      expect(page).to have_link("@mikekoul")
      expect(page).to have_link("@jonathanmpope")
      expect(page).to have_link("@alepbloyd")
    end
  end
end