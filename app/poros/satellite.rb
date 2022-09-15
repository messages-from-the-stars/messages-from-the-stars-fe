class Satellite
    attr_reader :id, :norad_id

    def initialize(data)
        @id = data[:id]
        @norad_id = data[:attributes][:norad_id]
    end 

end 