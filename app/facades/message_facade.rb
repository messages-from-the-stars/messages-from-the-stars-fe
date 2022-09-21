class MessageFacade

  def self.get_message(message_id)
    json = MessageService.get_message(message_id) 
    if json != 404
      Message.new(json)
    else 
      json 
    end 
  end

  def self.create_message(lat, long, message, sat_id)
    sat_id = sat_id.to_i
    json = MessageService.create_message(lat, long, message, sat_id)
  end

  def self.get_message_count(sat_id)
    MessageService.get_message_count(sat_id)
  end 

end