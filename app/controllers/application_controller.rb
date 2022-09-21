class ApplicationController < ActionController::Base
    helper_method :logged_in_user, :remote_ip, :lat_long 
# :nocov:
    def remote_ip
      if request.remote_ip == '127.0.0.1' || request.remote_ip == '::1'
        #hard coded as backup New York City
        lat_long('161.185.160.93')
      else
        lat_long(request.remote_ip)
      end
    end

    def lat_long(ip)
      location = Geocoder.search(ip)
      lat_long = location.first.coordinates
      @lat = lat_long[0]
      @long = lat_long[1]
    end 

    def logged_in_user
        unless session[:user_id]
            flash[:alert] = 'Please log in to view this page'
            redirect_to '/'
        end
    end
# :nocov:
end
