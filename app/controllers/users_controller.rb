class UsersController < ApplicationController
  before_action :sign_in_required, only: :show

  def index
    @users = User.all
  end

  def show
  end
end
