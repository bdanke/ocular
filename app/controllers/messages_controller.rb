class MessagesController < ApplicationController
  before_filter :require_current_user!

  def new
    in_message_threads = current_user.in_message_threads
    out_message_threads = current_user.out_message_threads
    first_pairs = in_message_threads.map { |thread| [thread.sender_id, thread] }
    second_pairs = out_message_threads.map { |thread| [thread.recipient_id, thread] }
    @messaged_friends_with_thread = first_pairs.concat(second_pairs).map { |pair| [User.find(pair[0]), pair[1]] }

    @recipient = User.find(params[:recipient_id])
    @sender = current_user
    @messages = []
    thread = MessageThread.find_by_users(@sender, @recipient)
    if thread
      @messages = thread.messages
      redirect_to user_message_thread_url(current_user, thread)
    else
      render :new
    end
  end

  def create
    message = Message.new(params[:message])
    message.owner_id = current_user.id
    @thread = MessageThread.find_by_ids(current_user.id, params[:recipient_id])
    if @thread
      message.thread_id = @thread.id
      message.save!
      redirect_to user_message_thread_url(current_user, @thread)
    else
      @thread = MessageThread.new()
      @thread.sender_id = current_user.id
      @thread.recipient_id = params[:recipient_id]
      @thread.save!
      message.thread_id = @thread.id
      message.save!
      redirect_to message_thread_url(current_user, @thread)
    end
  end
end