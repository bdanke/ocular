class MessagesController < ApplicationController
  def index
    message_threads = current_user.message_threads
    recipient_ids = message_threads.map { |thread| thread.recipient_id }
    @messaged_friends = recipient_ids.map { |id| User.find(id) }
  end

  def new
    @recipient = User.find(params[:recipient_id])
    @sender = current_user
    @messages = MessageThread.find_by_users(@user, @recipient).messages.order("messages.created_at")
    render :new
  end

  def show
    message_threads = current_user.message_threads
    recipient_ids = message_threads.map { |thread| thread.recipient_id }
    @messaged_friends = recipient_ids.map { |id| User.find(id) }
  end
end