class UsersController < ApplicationController
  before_action :sign_in_required
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show]
  before_action :admin_required, only: [:index, :edit, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end
  
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'アカウント情報を更新しました。' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
