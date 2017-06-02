class UsersController < ApplicationController
  before_action :sign_in_required
  before_action :admin_required, only: [:index, :destroy]

  def index
    @users = User.all
  end

  def show
  end
end
