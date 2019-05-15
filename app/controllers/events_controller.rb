class EventsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :is_admin, only: [:edit, :update, :destroy]
	before_action :is_validated, only: [:show]


	def index
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(admin: current_user, start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location])
		@event.save
		@event.picture.attach(params[:picture])


		if @event.save
			redirect_to root_path
			flash[:success] = "Your event has been successfully created"
		else
			flash.now[:error] = @event.errors.full_messages.to_sentence
			render :new
		end
	end

	def show
		@event = Event.find(params[:id])  	
	end

	def edit
		@event = Event.find(params[:id]) 
	end

	def update
		@event = Event.find(params[:id])
		
		if @event.update(admin: current_user, start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location])
			redirect_to event_path
			flash[:success] = "Your event has been successfully edited"
		else
			flash.now[:error] = @event.errors.full_messages.to_sentence
			render :edit
		end	
	end

	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to root_path
	end

	def is_admin
		@event = Event.find(params[:id])

		if current_user != @event.admin
			flash[:alert] = "You are not the organizer of this event"
			redirect_to event_path
		end

	end

	def has_picture
		if Event.picture.attached?
			return true
		else
			render 'new'
			flash[:alert] = "You must upload a picture"
		end
	end

	def is_validated
		@event = Event.find(params[:id])
		if @event.validated != true
			redirect_to root_path
			flash[:alert] = "Your event hasn't been validated"
		end
	end
end
