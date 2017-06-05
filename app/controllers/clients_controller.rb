class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :messages]

  def index
    @clients = Client.all
    render json: @clients
  end

  def create
    @client = Client.new(client_params)
    if @client.valid?
      @client.save
      render json: @client
    else
      render status: 400
    end
  end

  def show
    render json: @client
  end

  def messages
    render json: Message.where('sender_id = :user_id OR receiver_id = :user_id', user_id: @client.id)
  end

  private
  def set_client
    begin
      @client = Client.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: 404 and return
    end
  end

  def client_params
    params.require(:client).permit(:name, :email, :role, :password, :password_confirmation)
  end

end
