class ConversationsController < ApplicationController
  layout false
  before_action :authenticate_user!

  def new
  end

  def create
    recipients = User.where(id: conversation_params[:recipients])
    conversation = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject]).conversation
	 respond_to do |format|
	   format.html { head :no_content }
       format.js
       format.json { head :no_content }
  end
  end

  def show
    @receipts = conversation.receipts_for(current_user).order("created_at ASC")
    # mark conversation as read
    conversation.mark_as_read(current_user)
  end


  def reply
    current_user.reply_to_conversation(conversation, message_params[:body])
    #flash[:notice] = "Your reply message was successfully sent!"
     respond_to do |format|
	   format.html { head :no_content }
       format.js
       format.json { head :no_content }
  end
end

  def trash
    conversation.move_to_trash(current_user)
	 respond_to do |format|
	   format.html { head :no_content }
       format.js
       format.json { head :no_content }
	end
  end

  def empty_trash
    mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = 'Your trash was cleaned!'
	 respond_to do |format|
	   format.html { head :no_content }
       format.js
       format.json { head :no_content }
	end
  end

    def empty_sent
    mailbox.sentbox.each do |conversation|
      conversation.move_to_trash(current_user)
    end
    flash[:success] = 'Your sent was cleaned!'
	 respond_to do |format|
	   format.html { head :no_content }
       format.js
       format.json { head :no_content }
	end
  end

  

    def empty_inbox
    mailbox.inbox.each do |conversation|
      conversation.move_to_trash(current_user)
    end
    flash[:success] = 'Your inbox was cleaned!'
	 respond_to do |format|
	   format.html { head :no_content }
       format.js
       format.json { head :no_content }
	end
  end

  def untrash
    conversation.untrash(current_user)
	 respond_to do |format|
	   format.html { head :no_content }
       format.js
       format.json { head :no_content }
	end
  end




  private

  def conversation_params
    params.require(:conversation).permit(:subject, :body,recipients:[])
  end

  def message_params
    params.require(:message).permit(:body, :subject, :training_id )
  end
end