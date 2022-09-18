class MessageFacade

  def self.get_message(message_id)
    json = MessageService.get_message(message_id)
    
    Message.new(json)
  end

  def self.create_message(lat, long, message, sat_id)
    json = MessageService.create_message(lat, long, message, sat_id)
  end

end