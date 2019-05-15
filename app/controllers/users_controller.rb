class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:show]

  def show
  	dont_show
  	@user = User.find(params[:id])
  end

  def dont_show
  	@user = User.find(params[:id])
  	if @user != current_user
  		redirect_to root_path
  		flash[:alert] = "Condidential Information"
  	end
  end

  def edit
  	@user = User.find(params[:id])
  	redirect_to root_path, notice: "You can't edit this profile ma biche" unless current_user == @user
  end

  def update
  	@user = User.find(params[:id])
  	if current_user == @user
  		if @user.update(description: params[:description], first_name: params[:first_name], last_name: params[:last_name])
  			redirect_to user_path 
  			flash[:success] = "Your profile has been successfully edited"
  		else 
  			flash[:alert] = "Try again"
  			render :edit
  		end
  	else
  		redirect_to root_path, notice: "You can't edit this profile ma biche"
  	end
  end
end
