class CommentsController < ApplicationController
	def create
		
		comment = Comment.new(
			content: params[:content],
			user: current_user,
			event: Event.find(params[:event])
		)
		if comment.save
	  		redirect_to controller: 'events', action: 'show', id: params[:event]
	  	else
	  		flash[:errors] = user.errors.full_messages
	  		redirect_to "/events"
	  	end
  	
	end
end
