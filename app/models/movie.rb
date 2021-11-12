class Movie < ApplicationRecord
  # validations
  validates_presence_of [:title, :storyline, :cover, :imdb_id, :imdb_rating, :minutes, :released_at]
  validates_uniqueness_of [:imdb_id]

  # mounts
  mount_uploader :cover, ImageUploader
  mount_uploader :trailer, TrailerUploader

  # relations
  has_many :user_following, as: :followable
  has_many :following, through: :user_following, source: :followable, source_type: "Movie"

  def set_success(format, opts)
    self.success = true
  end
end
