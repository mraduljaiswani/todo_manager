class ApplicationController < ActionController::Base
    before_action :ensure_user_logged_in
  
    def ensure_user_logged_in
      unless current_user
        redirect_to "/"
      end
    end
  
    def current_user
      return @current_user if @current_user
  
      if session[:current_user_id]
        @current_user = User.find(session[:current_user_id])
      else
        nil
      end
    end
  end