class PicturesController < ApplicationController

  def create
  	@event = Event.find(params[:event_id])
  	@event.pictures.attach(params[:picture])
  end
end
