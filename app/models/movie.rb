class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :release_date, presence: true
  
  has_many :rentals

end
