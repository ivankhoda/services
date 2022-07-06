class CategoriesController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @category = Category.new
  end

  def index
    categories = Category.find_each
    render json: { categories: }
  end

  def show
    category = Category.find_by(id: params[:id])
    render json: { category: }
  end

  def create
    @category = Category.new(params)
    if @category.save
      render json: { message: 'Category succesfully created' }
    else
      render json: { error: @category.errors.messages }
    end
  end

  def update
    category = Category.find_by(id: params[:id])
    if !category.nil?
      category.update(params)
      render json: { category: }
    else
      render json: { error: 'Category not found' }, status: 422
    end
  end

  def destroy
    category = Category.find_by(id: params[:id])
    if !category.nil?
      category.destroy
      render json: { message: 'Category was removed' }
    else
      render json: { error: 'Category not found' }, status: 422
    end
  end

  private

  def params
    params.require(:category).permit(:title)
  end
end
