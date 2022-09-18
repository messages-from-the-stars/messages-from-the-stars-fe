class User 
    attr_reader :name, :username, :id

    def initialize(data)
        @id = data[:id]
        @name = data[:attributes][:name]
        @username = data[:attributes][:username]
    end 

end 