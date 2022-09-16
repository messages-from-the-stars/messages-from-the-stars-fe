class BaseService

    def self.connection 
        Faraday.new(url: 'https://messages-from-the-stars-be.herokuapp.com/')
    end

    def self.n2yo_conn
      Faraday.new(url: 'https://api.n2yo.com/rest/v1/satellite/') do |f|
        f.params['apiKey'] = ENV['space_key']
      end
    end

    def self.get_json(response)
        JSON.parse(response.body, symbolize_names: true)
    end 


end 