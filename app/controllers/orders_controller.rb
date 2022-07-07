class OrdersController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @order = Order.new
  end

  def index
    orders = Order.find_each
    render json: { orders: }
  end

  def show
    order = Order.find_by(id: params[:id])
    render json: { order: }
  end

  def create
    @order = Order.new(order_params)
    p order_params, 'params'
    if @order.save
      render json: OrderSerializer.new(@order)
    else
      render json: { error: @order.errors.messages }
    end
  end

  def update
    order = Order.find_by(id: params[:id])
    if !order.nil?
      order.update(params)
      render json: { order: }
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
                                  positions: [])
  end
end
