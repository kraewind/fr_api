class PayersController < ApplicationController

  # GET /balance
  def index
    @payers = Payer.all
    hashToBeRendered = {}    
    @payers.each do |payer|
      hashToBeRendered[payer.name] = payer.points
    end

    render json: @payers
  end

end
