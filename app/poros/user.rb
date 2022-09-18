class User 
    attr_reader :name, :username

    def initialize(data)
        @name = data[:attributes][:name]
        @username = data[:attributes][:username]
    end 

end 