class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action -> {restrict_access(@user.id)}, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:back]
      render :new
    else
      if @user.save
        redirect_to user_path(@user.id), notice: "Created the user!"
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "Edited the user!"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to new_user_registration_path, notice:"Deleted the user!"
  end


  def admin
    user = User.find_or_create_by!(email: 'admin@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
    end
    sign_in user
    redirect_to admin_root_path, notice: "Log in as an admin!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :introduce, :icon, :icon_cache)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
