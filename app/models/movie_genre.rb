class MovieGenre < ApplicationRecord
  # validations
  validates :genre, uniqueness: { scope: %i[movie_id] }

  # relations
  belongs_to :movie
  belongs_to :genre
end
