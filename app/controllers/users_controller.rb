class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome #{@user.username} to the Alpha Blog, you have signed up successfully"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    @articles = Article.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile Updations Were Made Successfuly"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    if(@user.destroy)
      session[:user_id] = nil
      flash[:notice] = "#{@user.username}'s Account Has Been Removed"
    end
    redirect_to articles_path
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  def set_user
    @user = User.find(params[:id])
  end

end