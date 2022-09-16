class ApplicationController < ActionController::Base

  def remote_ip
    if request.remote_ip == '127.0.0.1'
      #hard coded as backup New York City
      '161.185.160.93'
    else
      request.remote_ip
    end
  end
end
