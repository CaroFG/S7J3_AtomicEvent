class ChargesController < ApplicationController
	def new
        @event = Event.find(params[:id])
        @amount = @event.price
    end

    def create
        @event = Event.find(params[:id])
        @amount = @event.price * 100
      
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })

      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @amount,
        description: 'Rails Stripe customer',
        currency: 'eur',
      })

      @attendance = Attendance.create(stripe_customer_id: customer.id, user: current_user, event: @event)
        redirect_to event_path(@event.id)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
end
