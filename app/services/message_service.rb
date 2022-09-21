class MessageService
  
  def self.get_message(message_id)
    response = BaseService.connection.get("api/v1/messages/#{message_id}")
    if response.status != 404 
      BaseService.get_json(response)
    else 
      response.status 
    end 
  end

  def self.create_message(lat, long, message, sat_id)
    message_params = {
      satellite_id: sat_id,
      start_lat: lat,
      start_lng: long,
      content: message
    }
    response = BaseService.connection.post("api/v1/messages/", JSON.generate(message: message_params), "Content-Type" => "application/json")
    BaseService.get_json(response)
  end

  def self.get_message_count(sat_id)
    response = BaseService.connection.get("api/v1/messages/find_by_norad_id?norad_id=#{sat_id}")
    BaseService.get_json(response)
  end

end