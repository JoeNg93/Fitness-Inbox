class MessagesController < ApplicationController
  before_action :set_message, only: [:show]

  def index
    render json: Message.all
  end

  def show
    render json: @message
  end

  def create
    @message = Message.new(message_params)
    if @message.valid?
      @message.save
      render json: @message
    else
      render status: 400
    end
  end

  private
  def set_message
    begin
      @message = Message.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: {},status: 404 and return
    end
  end

  def message_params
    params.require(:message).permit(:content, :sender_id, :receiver_id)
  end
end
