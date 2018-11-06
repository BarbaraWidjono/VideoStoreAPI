class RentalsController < ApplicationController
  def create
    rental = Rental.new(rental_params)
    if rental.save
      change_avail_inventory(rental_params[:movie_id])
      # binding.pry
      render json: { id: rental.id }
    else
      render_error(:bad_request, {rental: ["no such rental"]})
    end
  end


  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end


end
