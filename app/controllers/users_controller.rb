class UsersController < ApplicationController
  before_action :set_user, only: %i[edit show destroy update]

  def new
    @user = User.new
    @articles = @user.articles
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to G Blog #{@user.user_name} !"
      redirect_to articles_path
    else
      render :new
    end      
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User updated!"
      redirect_to articles_path
    else
      render :edit
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end