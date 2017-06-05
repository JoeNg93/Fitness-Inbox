class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :messages, :mark_read]
  skip_before_action :verify_authenticity_token

  def index
    @clients = Client.all
    render json: @clients
  end

  def create
    @client = Client.new(client_params)
    if @client.valid?
      @client.save
      cookies.permanent.signed[:user_id] = @client.id
      render json: @client
    else
      if @client.errors.messages[:email]
        render json: {error: 'Email has already been taken'}, status: 400 and return
      end
      render json: {error: 'Client information is not valid'}, status: 400
    end
  end

  def show
    render json: @client
  end

  def messages
    render json: Message.where('sender_id = :user_id OR receiver_id = :user_id', user_id: @client.id)
  end

  def mark_read
    sender_id = params[:sender_id]
    @client.unread_messages.select { |message| message.sender_id == sender_id.to_i }.each do |message|
      message.update_attribute(:read, true)
    end
    render json: @client.reload
  end

  private
  def set_client
    begin
      @client = Client.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: {error: 'Client not found'}, status: 404 and return
    end
  end

  def client_params
    params.require(:client).permit(:name, :email, :role, :password, :password_confirmation)
  end

end
