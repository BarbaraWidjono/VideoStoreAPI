class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movify(movies), status: :ok
  end

  def show
    movie_id = params[:id]
    movie = Movie.find_by(id: movie_id)
    if movie
      render json: movify(movie), status: :ok
    else
      render_error(:not_found, {movie_id: ["No such movie"]})
    end
  end

  private

  def movify(movie_data)
    return movie_data.as_json(only: [:id, :title, :release_date])
  end
end
