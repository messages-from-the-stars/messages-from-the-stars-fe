class MessageService
  
  def self.get_message(message_id)
    response = BaseService.connection.get("/api/v1/messages/#{message_id}")
    BaseService.get_json(response)
  end

end