class HomeController < ApplicationController
  def index
  end

  def show
    @foods = Food.all
  end
end
