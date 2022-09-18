class MessageService
  
  def self.get_message(message_id)
    response = BaseService.connection.get("api/v1/messages/#{message_id}")
    BaseService.get_json(response)
  end

  def self.create_message(lat, long, message, sat_id)
    message_params = ({
      satellite_id: sat_id,
      start_lat: lat,
      start_lng: long,
      content: message
    })
    response = BaseService.connection.post("api/v1/messages/") do |req|
      # req.params['satellite_id'] = sat_id
      # req.params['start_lat'] = lat
      # req.params['start_ng'] = long
      # req.params['content'] = message
      req.headers['Content-Type'] = 'application/json'
      req.params[:message] = message_params
    end 
    binding.pry 
    BaseService.get_json(response)
  end

end