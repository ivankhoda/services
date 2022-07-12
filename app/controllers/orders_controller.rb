class OrdersController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @order = Order.new
  end

  def index
    query = Query::OrderSorter.new(params['search_term'])
    orders = []
    if query.request.has_key?('category_id')
      services = Service.where(query.request)
      order_ids = []
      services.each do |service|
        order_ids << service.order_id
      end
      orders = Order.where(id: order_ids)
    else
      orders = Order.where(query.request)
    end
    render json: OrderSerializer.new(orders)
  end

  def show
    order = Order.find_by(id: params[:id])
    render json: OrderSerializer.new(order).serializable_hash
  end

  def create
    par = order_params.except(:positions)
    order = Order.new(par)
    if order.save
      order_params[:positions].each do |pos|
        position = Service.create!({ title: pos[:title], category_id: pos[:category_id], order_id: order.id })
        order.positions << position[:title]
      end
      render json: OrderSerializer.new(order)
    else
      render json: { error: order.errors.messages }
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

    @orders = []
    if query.request.has_key?('category_id')
      services = Service.where(query.request)
      order_ids = []
      services.each do |service|
        order_ids << service.order_id
      end
      @orders = Order.where(id: order_ids)
    else
      @orders = Order.where(query.request)
    end

    respond_to do |format|
      format.xlsx
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="data.xlsx"'
      end
    end

    p = Axlsx::Package.new
    p.workbook do |wb|
      wb.add_worksheet(name: 'Orders') do |sheet|
        sheet.add_row %w[Id Date Client Assignee Positions Amount]
        @orders.each do |order|
          order_positions = ''

          if order.services
            order.services.each do |pos|
              order_positions << "#{pos[:title]}\n"
            end
          end

          sheet.add_row [order.id, order.created_at, order.client_name, order.assignee_name, order_positions,
                         order.price]
        end
      end
    end
    p.serialize("#{Rails.root}/tmp/data.xlsx")

    send_file "#{Rails.root}/tmp/data.xlsx", filename: 'data.xlsx', type: 'application/vnd.ms-excel',
                                             disposition: 'attachment'
  end

  private

  def order_params
    params.require(:order).permit(:id, :client_name, :assignee_name, :price, :client_id, :assignee_id,
                                  positions: %i[title category_id category_title])
  end
end
