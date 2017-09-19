class HomeController < ApplicationController
  before_action :sign_in_required, only: :show

  def index
    redirect_to home_show_url if user_signed_in?
  end

  def show
    @foods = Food.all
  end
end
