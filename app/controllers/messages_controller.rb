class MessagesController < ApplicationController

	before_action do
    	@conversation = Conversation.find(params[:conversation_id])
  	end

	def index
		@messages = @conversation.messages
  		if @messages.length > 10
   			@over_ten = true
   			@messages = @messages[-10..-1]
  		end
  
  		if params[:m]
   			@over_ten = false
   			@messages = @conversation.messages
  		end
 
 		if @messages.last
  			if @messages.last.user_id != current_user.id
   				@messages.last.read = true;
  			end
		 end

		@message = @conversation.messages.new
 	end

	def new
 		@message = @conversation.messages.new
	end

	def create
 		@message = @conversation.messages.new(message_params)
 		if @message.save
      if doctor_signed_in?
        @conversation.unread_messages = true
        @conversation.save
      elsif user_signed_in?
        @conversation.sender_unread_messages = true
        @conversation.save
      end
      redirect_to conversation_path(@conversation)
 		end
	end

	private
		def message_params
  			params.require(:message).permit(:body, :user_class, :user_id, :image)
 		end
end