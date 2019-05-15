class Gods::EventsController < ApplicationController
	def index
		@events = Event.all
	end

	def show
		@event = Event.find(params[:id])
	end

	def new
		@event = Event.new
	end

  def create
    @event = Event.new(admin: current_user, start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location])
    @event.save
    redirect_to gods_index_path
    flash[:success] = "The event has been created"
  end

  def edit
  	@event = Event.find(params[:id])
  end
	def update
		@event = Event.find(params[:id])
		@event.update(validated: params[:validated])
		if @event.update(validated: params[:validated]) && @event.validated == true
			UserMailer.event_validated_email(@event.admin, @event).deliver_now
		end
		redirect_to gods_events_path
	end
	


  def destroy
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to gods_events_path
	end


end