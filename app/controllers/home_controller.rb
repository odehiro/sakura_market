class HomeController < ApplicationController
  before_action :sign_in_required

  def index
  end

  def show
    @foods = Food.all
  end
end
