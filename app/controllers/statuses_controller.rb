class StatusesController < ApplicationController
  def create
    status = Status.new(params[:status])
    status.owner_id = current_user.id
    status.wall_user_id = params[:user_id]

    if status.save
      head :ok
    else
      render json: status.errors.full_messages
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