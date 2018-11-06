class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :release_date, presence: true

  has_many :rentals



  def change_avail_inventory(id)
    movie = Movie.find_by(id: id)
    movie.available_inventory -= 1
  end

  # def self.change_avail_inventory(movie_id)
  #   movie = Movie.find_by(id: movie_id )
  #   movie.available_inventory -= 1
  # end

end
