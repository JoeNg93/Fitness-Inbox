class ClientsController < ApplicationController
  before_action :set_client, only: [:show]

  def index
    @clients = Client.all
    render json: @clients
  end

  def create
  end

  def show
    render json: @client
  end

  private
  def set_client
    begin
      @client = Client.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: 404 and return
    end
  end

end
