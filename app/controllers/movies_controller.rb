require 'date'
class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movify_index(movies), status: :ok
  end

  def show
    movie_id = params[:id]
    movie = Movie.find_by(id: movie_id)
    if movie
      render json: movify_show(movie), status: :ok
    else
      render_error(:not_found, {movie_id: ["No such movie"]})
    end
  end

  def create
    movie = Movie.new(movie_params)
    movie.available_inventory = movie.inventory
    
    if movie.save
      render json: { id: movie.id }
    else
      render_error(:bad_request, movie.errors.messages)
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end

  def movify_index(movie_data)
    return movie_data.as_json(only: [:id, :title, :release_date])
  end

  def movify_show(movie_data)
    return movie_data.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory])
  end




end
