class UserService
  
  def self.find_or_create_user(name, username)
    response = BaseService.connection.get("/api/v1/users/find_or_create_user?username=#{username}&name=#{name}")
    binding.pry 
    BaseService.get_json(response)
  end

end 