require 'rails_helper'

RSpec.describe UserFacade do
    describe '#find_or_create_user' do
        it 'returns a user' do

            @user = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)

            allow(UserService).to receive(:find_or_create_user).and_return(@user)

            results = UserFacade.find_or_create_user("Bob Bobbycus", "test@test.com")
            
            expect(results).to be_a User
            expect(results.name).to eq("Bob Bobbycus")
            expect(results.username).to eq("test@test.com")
        end 
    end
end 

