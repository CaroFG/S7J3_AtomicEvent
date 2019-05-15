class Gods::UsersController < ApplicationController

	def index
    @users = User.all
  end

  def show
     @user = User.find(params[:id]) 
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password], description: params[:description])
    @user.save
    redirect_to gods_index_path
    flash[:success] = "The user has been created"
  end

  def edit 
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(description: params[:description], first_name: params[:first_name], last_name: params[:last_name])
      redirect_to gods_users_path
      flash[:success] = "The user has been updated"
    else
      flash[:alert] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to gods_users_path
    flash[:success] = "The user has been deleted"
  end
end
