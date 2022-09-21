require 'rails_helper'

RSpec.describe UserService do

    describe '#find_or_create_user' do
        it 'returns a user', :vcr do
            user_return = UserService.find_or_create_user("Jonathan Pope", "jonathanmpope@gmail.com")
               
            expect(user_return).to be_a(Hash)

            expect(user_return).to have_key(:data)
            expect(user_return[:data]).to be_a(Hash)

            expect(user_return[:data]).to have_key(:type)
            expect(user_return[:data][:type]).to be_a(String)

            expect(user_return[:data]).to have_key(:attributes)
            expect(user_return[:data][:attributes]).to be_a(Hash)

            expect(user_return[:data][:attributes]).to have_key(:name)
            expect(user_return[:data][:attributes][:name]).to be_a(String)

            expect(user_return[:data][:attributes]).to have_key(:username)
            expect(user_return[:data][:attributes][:username]).to be_a(String)
        end 
    end
end