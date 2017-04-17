class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    #users_show_path
    home_show_path
  end

  private 
    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end
end
