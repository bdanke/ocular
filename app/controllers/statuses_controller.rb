class StatusesController < ApplicationController
  before_filter :require_current_user!
  before_filter :require_self_or_friend!

  def create
    status = Status.new(params[:status])
    status.owner_id = current_user.id
    status.wall_user_id = params[:user_id] || current_user.id
    if status.save
      if request.xhr?
        render partial: "statuses/show", locals: {status: status}
      else
        redirect_to :back
      end
    else
      if request.xhr?
        head :ok
      else
        redirect_to :back
      end
    end
  end

  def edit
    @user = current_user
    @status = Status.find(params[:id])
    render :edit
  end

  def update
    status = Status.find(params[:id])
    if status.update_attributes(params[:status])
      redirect_to :back
    else
      render json: status.errors.full_messages
    end
  end

  def destroy
    Status.find(params[:id]).destroy
    redirect_to :back
  end
end