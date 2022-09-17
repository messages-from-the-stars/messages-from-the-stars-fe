class MessageFacade

  def self.get_message(message_id)
    json = MessageService.get_message(message_id)
    
    Message.new(json)
  end

end