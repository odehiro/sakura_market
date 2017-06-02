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

    def admin_required
      redirect_to home_show_url unless current_user.admin?
    end
   
    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end
