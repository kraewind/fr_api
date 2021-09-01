class PayersController < ApplicationController

  # GET /balance
  def index
    @payers = Payer.all

    render json: @payers
  end

end
