class GodsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_if_god
  def index
  end

  def check_if_god
  	if current_user.is_god == false 
  		flash[:alert] = "You shall not pass"
  		redirect_to root
  	end
  end
end
