class Movie < ApplicationRecord
  # validations
  validates_presence_of [:title, :storyline, :cover, :imdb_id, :imdb_rating, :minutes, :released_at]
  validates_uniqueness_of [:imdb_id]

  # mounts
  mount_uploader :cover, ImageUploader
  mount_uploader :trailer, TrailerUploader

  def set_success(format, opts)
    self.success = true
  end
end
