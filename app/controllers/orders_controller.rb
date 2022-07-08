class OrdersController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @order = Order.new
  end

  def index
    orders = Order.find_each
    render json: OrderSerializer.new(orders)
  end

  def show
    order = Order.find_by(id: params[:id])
    render json: OrderSerializer.new(order).serializable_hash
  end

  def create
    par = order_params.except(:positions)
    @order = Order.new(par)
    if @order.save
      order_params[:positions].each do |pos|
        position = Service.create!({ title: pos[:title], category_id: pos[:category_id], order_id: @order.id })
        @order.positions << position[:title]
        p @order
      end
      render json: OrderSerializer.new(@order)
    else
      render json: { error: @order.errors.messages }
    end
  end

  def update
    order = Order.find_by(id: params[:id])
    if !order.nil?
      order.update(params)
      render json: OrderSerializer.new(order).serializable_hash
    else
      render json: { error: 'Order not found' }, status: 422
    end
  end

  def destroy
    order = Order.find_by(id: params[:id])
    if !order.nil?

      order.destroy
      render json: { message: 'Order was removed' }
    else
      render json: { error: 'Order not found' }, status: 422
    end
  end

  private

  def order_params
    params.require(:order).permit(:client_name, :assignee_name, :price, :client_id, :assignee_id,
                                  positions: %i[title category_id position_id])
  end
end
