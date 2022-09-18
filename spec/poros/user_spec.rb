require "rails_helper"

RSpec.describe User do
    it "exists" do
            data = {
                "id": "2",
                "type": "user",
                "attributes": {
                    "name": "Bob Bobbycus",
                    "username": "test@test.com"
                }
            }
            
        user = User.new(data)

        expect(user).to be_a User
        expect(user.name).to eq("Bob Bobbycus")
        expect(user.username).to eq("test@test.com")
    end 
end 