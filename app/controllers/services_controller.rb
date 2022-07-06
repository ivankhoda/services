class ServicesController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @service = Service.new
  end

  def index
    services = Service.find_each
    render json: { services: }
  end

  def show
    service = Service.find_by(id: params[:id])
    render json: { service: }
  end

  def create
    @service = Service.new(params)
    if @service.save
      render json: { message: 'Service succesfully created' }
    else
      render json: { error: @service.errors.messages }
    end
  end

  def update
    service = Service.find_by(id: params[:id])
    if !service.nil?
      service.update(params)
      render json: { service: }
    else
      render json: { error: 'Service not found' }, status: 422
    end
  end

  def destroy
    service = Service.find_by(id: params[:id])
    if !service.nil?
      service.destroy
      render json: { message: 'Service was removed' }
    else
      render json: { error: 'Service not found' }, status: 422
    end
  end

  private

  def params
    params.require(:service).permit(:name, :alias, :codetype_id)
  end
end
