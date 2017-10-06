class UsersController < ApplicationController
  before_action :sign_in_required
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show]
  before_action :admin_required, only: [:index, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :password,
                                   :password_confirmation,
                                   :to_address,
                                   :admin)
    end

    def correct_user
      @user = User.find(params[:id])
      if !current_user.admin?
        redirect_to(home_show_url) unless current_user == @user
      end
    end

    def admin_user
      redirect_to(home_show_url) unless current_user.admin?
    end
end
