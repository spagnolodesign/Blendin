class InboxController < ApplicationController


  def index
    @conversations = current_user.mailbox.inbox
    @messages_unread_count = current_user.mailbox.inbox({:read => false}).count
  end

  def show
    set_conversation
    @receipts = @conversation.receipts_for current_user
    render :action => :show
    @receipts.mark_as_read
  end

  def reply
    set_conversation
    response = params[:message][:body]
    send_message = current_user.reply_to_conversation(@conversation, response)

    respond_to do |format|
      if send_message.save
        format.html { redirect_to inbox_path(@conversation), notice: "Message sent" }
      else
        format.html { render :show, alert: "Error message sent" }
      end
    end

  end

  def set_conversation
    @conversation = current_user.mailbox.inbox.order('created_at DESC').find(params[:id])
  end

end
