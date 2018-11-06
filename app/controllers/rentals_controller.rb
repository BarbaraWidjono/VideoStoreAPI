require 'date'
class RentalsController < ApplicationController
  def create
    rental = Rental.new(rental_params)
    rental.check_out_date = Date.today
    rental.due_date = (Date.today + 7)

    if rental.save
      change_avail_inventory(rental_params[:movie_id])
      render json: { id: rental}
    else
      render_error(:bad_request, {rental: ["no such rental"]})
    end
  end

  def destroy
    rental =  Rental.find_by(id: check_params[:id])
    temp = rental.id
    if rental.destroy
      render json: { message: "#{temp} has been delted"}
    end
  end






  private

  def check_params
    params.require(:rental).permit(:id)
  end

  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end

  def change_avail_inventory(id)
    movie = Movie.find_by(id: id)
    movie.available_inventory -= 1
    movie.save
  end

end
