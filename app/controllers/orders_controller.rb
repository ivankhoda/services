class OrdersController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @order = Order.new
  end

  def index
    query = Query::OrderSorter.new(params['search_term'])

    orders = Order.where(query.request)

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
      end
      render json: OrderSerializer.new(@order)
    else
      render json: { error: @order.errors.messages }
    end
  end

  def update
    order = Order.find_by(id: params[:id])
    if !order.nil?
      order.update(order_params)
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

  def export
    require 'axlsx'
    query = Query::OrderSorter.new(params['search_term'])

    @orders = Order.where(query.request)

    respond_to do |format|
      format.xlsx

      format.html
    end

    # p = Axlsx::Package.new
    # p.workbook do |wb|
    #   wb.add_worksheet(name: 'Orders') do |sheet|
    #     sheet.add_row %w[Id Date Client Assignee Positions Amount]
    #     @orders.each do |order|
    #       sheet.add_row [order.id, order.created_at, order.client_name, order.assignee_name, @positions,
    #                      order.price]
    #     end
    #   end
    # end
    # p.serialize 'data.xlsx'

    # format.xlsx{ filename =>'data.xlsx' }
    render xlsx: 'data', filename: 'data.xlsx'
  end

  private

  def order_params
    params.require(:order).permit(:id, :client_name, :assignee_name, :price, :client_id, :assignee_id,
                                  positions: %i[title category_id category_title position_id order_id id created_at updated_at])
  end
end
