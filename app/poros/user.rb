class User 
    attr_reader :name, :username

    def initialize(data)
        @name = data[:name]
        @username = data[:username]
    end 

end 