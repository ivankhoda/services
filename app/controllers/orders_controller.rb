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
    @order = Order.new({ client_name: order_params[:client_name], assignee_name: order_params[:assignee_name],
                         price: order_params[:price], client_id: order_params[:client_id], assignee_id: order_params[:assignee_id] })
    # @order = Order.new(order_params)

    @positions = Service.where(id: order_params[:service_id])
    # @order.positions = order_params[:positions]
    p @positions
    positions_ids = @positions.map { |pos| pos.id }
    pos_title = @positions.map { |pos| pos.title }
    p pos_title, pos_title.class
    p positions_ids, positions_ids.class
    @order.positions
    p @order.positions, @order.positions.class

    # @order.service_id = positions_ids
    # p @order
    # @order.positions << order_positions
    # @order.positions_id << order_positions_ids
    # if @order.save
    #   render json: OrderSerializer.new(@order)
    # else
    #   render json: { error: @order.errors.messages }
    # end
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
    params.require(:order).permit(:client_name, :assignee_name, :price, :client_id, :assignee_id, service_id: [],
                                                                                                  positions: [])
  end
end
