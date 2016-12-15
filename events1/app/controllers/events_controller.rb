class EventsController < ApplicationController

	def index
		@in_state_events = Event.where(state: current_user.state).includes(:host, :users)
		@out_of_state_events = Event.where.not(state: current_user.state).includes(:host, :users, :state)
	end
	def create
		event = Event.new(
		  event_params.merge({
			state: State.find(event_params[:state]),
			host: current_user
			})
		)
		if event.save
	  		
	  		redirect_to "/events"
	  	else
	  		flash[:errors] = event.errors.full_messages
	  		redirect_to "/events"
	  	end
  	
	end

	def destroy
		Event.find(params[:id]).destroy
		redirect_to '/events'
	end
	def edit
		@event = Event.find(params[:id])
	end

	def show
		@event = Event.find(params[:id])
		@comment = Comment.all
	end
	def update
		event = Event.find(params[:id])
		event.update(
			event_params.merge(
				state: State.find(event_params[:state])
			)
		)
		# event.update(name: event_params[:name], date: event_params[:date], city: event_params[:city], state: event_params[:state])
		redirect_to '/events'
	end

	private
      def event_params
      	params.require(:event).permit(:name, :date, :city, :state) 
			
	  end
end
