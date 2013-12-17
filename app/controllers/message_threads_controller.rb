class MessageThreadsController < ApplicationController
	before_filter :require_self!

	def index
    in_message_threads = current_user.in_message_threads
    out_message_threads = current_user.out_message_threads
    first_pairs = in_message_threads.map { |thread| [thread.sender_id, thread] }
    second_pairs = out_message_threads.map { |thread| [thread.recipient_id, thread] }
    @messaged_friends_with_thread = first_pairs.concat(second_pairs).map { |pair| [User.find(pair[0]), pair[1]] }

    if request.xhr?
      render partial: "message_threads/index", locals: {messaged_friends_with_thread: @messaged_friends_with_thread}
    else
      render :index
    end
	end

	def show
    in_message_threads = current_user.in_message_threads
    out_message_threads = current_user.out_message_threads
    first_pairs = in_message_threads.map { |thread| [thread.sender_id, thread] }
    second_pairs = out_message_threads.map { |thread| [thread.recipient_id, thread] }
    @messaged_friends_with_thread = first_pairs.concat(second_pairs).map { |pair| [User.find(pair[0]), pair[1]] }

  	@thread = MessageThread.find(params[:id])
    their_id = @thread.sender_id == current_user.id ? @thread.recipient_id : @thread.sender_id
    @them = User.find(their_id)

    if request.xhr?
      render partial: "message_threads/show", locals: {thread: @thread, them: @them}
    else
      render :show
    end
	end
end