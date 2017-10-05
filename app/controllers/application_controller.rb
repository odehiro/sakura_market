class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    home_show_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def admin_required
    redirect_to home_show_url unless current_user.admin?
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit :sign_up, keys: [:name, :to_address]
      devise_parameter_sanitizer.permit :account_update, keys: [:name, :to_address]
    end

  private
    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end
   
    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end
