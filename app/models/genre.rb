class Genre < ApplicationRecord
  # validations
  validates_presence_of :name
  validates_uniqueness_of :name

  # relations
  has_many :user_following, as: :followable
  has_many :following, through: :user_following, source: :followable, source_type: "Genre"

  has_many :movie_genres
  has_many :movies, through: :movie_genres
end
