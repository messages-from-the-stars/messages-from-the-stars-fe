class ApplicationController < ActionController::Base

    helper_method :logged_in_user

    def logged_in_user
        unless session[:user_id]
            flash[:alert] = 'Please log in to view this page'
            redirect_to '/'
        end
    end

end
