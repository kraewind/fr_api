class PayersController < ApplicationController
  before_action :set_payer, only: [:show, :update, :destroy]

  # GET /payers
  def index
    @payers = Payer.all

    render json: @payers
  end

  # GET /payers/1
  def show
    render json: @payer
  end

  # POST /payers
  def create
    @payer = Payer.new(payer_params)

    if @payer.save
      render json: @payer, status: :created, location: @payer
    else
      render json: @payer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payers/1
  def update
    if @payer.update(payer_params)
      render json: @payer
    else
      render json: @payer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /payers/1
  def destroy
    @payer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payer
      @payer = Payer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payer_params
      params.fetch(:payer, {})
    end
end
