class UsersController < ApplicationController
  before_action :set_user, only: %i[edit show destroy update]
  before_action :require_user, only: %i[edit update]
  before_action :require_self_user, only: %i[edit update destroy]


  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
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
      redirect_to @user
    else
      render :edit
    end
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and associated articles destroyed"
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_self_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit your account"
      redirect_to @user
    end
  end
end