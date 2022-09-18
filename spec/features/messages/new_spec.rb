require 'rails_helper'

RSpec.describe 'message new page' do
    before :each do
        
    end

    xit 'has a form to create a new message' do
        visit "/messages/new" 

        fill_in("message", with: "Hello there, this is a test")
        click_button('Send Message')

        expect(current_path).to eq('/users/dashboard')
        expect(page).to have_content("Message sent!")
    end

    it 'will not let you send a blank message' do
        visit "/messages/new" 

        click_button('Send Message')

        expect(page).to have_content("Your message can't be blank!")
        expect(current_path).to eq("/messages/new")
    end

end
