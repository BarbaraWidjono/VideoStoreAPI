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
    rental =  Rental.find_by(customer_id: check_params[:customer_id], movie_id: check_params[:movie_id])
    if !rental
      render json: { message: "Rental id: #{check_params[:id]} doesn't exist. Try again"}
    else

      temp = rental.id
      temp_movie_id = rental.movie_id
      if rental.destroy
        checkin_change_avail_inventory(temp_movie_id)
        render json: { message: "Rental id: #{temp} has been deleted"}
      end
    end
  end






  private

  def check_params
    params.require(:rental).permit(:customer_id, :movie_id)
  end

  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end

  def change_avail_inventory(id)
    movie = Movie.find_by(id: id)
    movie.available_inventory -= 1
    movie.save
  end

  def checkin_change_avail_inventory(id)
    movie = Movie.find_by(id: id)
    movie.available_inventory += 1
    movie.save
  end
end
