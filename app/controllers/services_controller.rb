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
    category = Category.find_by(title: service_params[:service_category])
    service = Service.new(title: service_params[:title], category_title: category.title, category_id: category.id)

    if service.save
      render json: { service: }
    else
      render json: { error: @service.errors.messages }
    end
  end

  def update
    service = Service.find_by(id: params[:id])
    category = Category.find_by(title: service_params[:service_category])
    if !service.nil?
      service.update(title: service_params[:title], category_title: category.title, category_id: category.id)
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

  def service_params
    params.require(:service).permit(:title, :service_category, :category_id)
  end
end
