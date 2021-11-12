class MovieCast < ApplicationRecord
  # validations
  validates_presence_of :role
  validates :cast, uniqueness: { scope: %i[movie_id cast_id role] }

  # relations
  belongs_to :movie
  belongs_to :cast

  # enumerables
  enum role: [:star, :writer, :director]
end
