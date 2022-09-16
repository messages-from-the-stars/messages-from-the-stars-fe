class ApplicationController < ActionController::Base
  helper_method :logged_in_user

  def remote_ip
    if request.remote_ip == '127.0.0.1'
      #hard coded as backup New York City
      '161.185.160.93'
    else
      request.remote_ip
    end
  end

    

    def logged_in_user
        unless session[:user_id]
            flash[:alert] = 'Please log in to view this page'
            redirect_to '/'
        end
    end
end
