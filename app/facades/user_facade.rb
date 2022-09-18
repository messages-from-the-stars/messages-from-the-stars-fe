class UserFacade

    def self.find_or_create_user(name, username)
        json = UserService.find_or_create_user(name, username)
        User.new(json)
    end 
end 