class ClientsController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @client = Client.new
  end

  def index
    clients = Client.find_each
    render json: { clients: }
  end

  def show
    client = Client.find_by(id: params[:id])
    render json: { client: }
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      render json: { message: 'Client succesfully created' }
    else
      render json: { error: @client.errors.messages }
    end
  end

  def update
    client = Client.find_by(id: params[:id])
    if !client.nil?
      client.update(client_params)
      render json: { client: }
    else
      render json: { error: 'Client not found' }, status: 422
    end
  end

  def destroy
    client = Client.find_by(id: params[:id])
    if !client.nil?

      client.destroy
      render json: { message: 'Client was removed' }
    else
      render json: { error: 'Client not found' }, status: 422
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :surname)
  end
end
