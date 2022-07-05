class AssigneesController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @assignee = Assignee.new
  end

  def index
    assignees = Assignee.find_each
    render json: { assignees: }
    # AssigneeSerializer.new(assignees).serializable_hash
  end

  def show
    assignee = Assignee.find_by(id: params[:id])
    render json: { assignee: }
  end

  def create
    @assignee = Assignee.new(vendor_params)
    if @assignee.save
      render json: { message: 'Assignee succesfully created' }
    else
      render json: { error: @assignee.errors.messages }
    end
  end

  def update
    assignee = Assignee.find_by(id: params[:id])
    if !assignee.nil?
      assignee.update(vendor_params)
      render json: { assignee: }
    else
      render json: { error: 'Assignee not found' }, status: 422
    end
  end

  def destroy
    assignee = Assignee.find_by(id: params[:id])
    if !assignee.nil?
      assignee.task_ranges.destroy
      assignee.destroy
      render json: { message: 'Assignee was removed' }
    else
      render json: { error: 'Assignee not found' }, status: 422
    end
  end

  private

  def params
    params.require(:assignee).permit(:name, :surname)
  end
end
