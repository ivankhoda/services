class GenericServicesController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @generic_service = GenericService.new
  end

  def index
    generic_services = GenericService.find_each
    render json: { generic_services: } if generic_services
  end

  def show
    generic_service = GenericService.find_by(id: params[:id])
    render json: { generic_service: } if generic_service
  end

  def create
    category = Category.find_by(title: generic_service_params[:service_category])
    generic_service = GenericService.new(title: generic_service_params[:title], category_title: category.title,
                                         category_id: category.id)

    if generic_service.save
      render json: { generic_service: }
    else
      render json: { error: @generic_service.errors.messages }
    end
  end

  def update
    generic_service = GenericService.find_by(id: params[:id])
    category = Category.find_by(title: generic_service_params[:service_category])
    if !generic_service.nil?
      generic_service.update(title: generic_service_params[:title], category_title: category.title,
                             category_id: category.id)
      render json: { generic_service: }
    else
      render json: { error: 'GenericService not found' }, status: 422
    end
  end

  def destroy
    generic_service = GenericService.find_by(id: params[:id])
    if !generic_service.nil?
      generic_service.destroy
      render json: { message: 'GenericService was removed' }
    else
      render json: { error: 'GenericService not found' }, status: 422
    end
  end

  private

  def generic_service_params
    params.require(:generic_service).permit(:title, :service_category, :category_id)
  end
end
