class UserFacade

    def self.find_or_create_user(name, username)
        json = UserService.find_or_create_user(name, username)[:data]
        User.new(json)
    end 
end 