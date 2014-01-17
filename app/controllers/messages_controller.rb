class MessagesController < ApplicationController
  before_filter :require_current_user!

  def new
    @recipient = User.find(params[:recipient_id])
    @sender = current_user
    thread = MessageThread.find_by_users(@sender, @recipient)

    if request.xhr?
      if thread
        render partial: "message_threads/show", locals: {thread: thread, them: @recipient}
      else
        render partial: "messages/form", locals: {recipient: @recipient}
      end
    else
      if thread
        @messages = thread.messages
        redirect_to user_message_thread_url(current_user, thread)
      else
        render :new
      end
    end
  end

  def create
    message = Message.new(params[:message])
    message.owner_id = current_user.id
    recipient = User.find(params[:recipient_id])
    @thread = MessageThread.find_by_users(current_user, recipient)
    if @thread
      message.thread_id = @thread.id
      # message.seen = "F"
      message.save!
      if request.xhr?
        render partial: "message_threads/show", locals: {thread: @thread, them: recipient}
      else
        redirect_to user_message_thread_url(current_user, @thread)
      end
    else
      @thread = MessageThread.new()
      @thread.sender_id = current_user.id
      @thread.recipient_id = params[:recipient_id]
      @thread.save!
      message.thread_id = @thread.id
      # message.seen = "F"
      message.save!
      if request.xhr?
        render partial: "message_threads/show", locals: {thread: @thread, them: recipient}
      else
        redirect_to user_message_thread_url(current_user, @thread)
      end
    end
  end
end