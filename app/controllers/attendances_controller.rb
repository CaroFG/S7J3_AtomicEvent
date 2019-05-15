class AttendancesController < ApplicationController

	def index
		@event = Event.find(params[:id])
	end

	def new
	end

	def create
		@event = Event.find(params[:id])
		@attendance = Attendance.create(stripe_customer_id: "Free", user: current_user, event: @event)
		flash[:success] = "You joined the fucking event"
		redirect_to root_path
	end
end
