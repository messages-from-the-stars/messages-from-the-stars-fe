class BaseService

    def self.connection 
        Faraday.new(url: 'https://messages-from-the-stars-be.herokuapp.com/')
    end 

    def self.get_json(response)
        JSON.parse(response.body, symbolize_names: true)
    end 

end 