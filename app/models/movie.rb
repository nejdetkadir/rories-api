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
  
  has_many :movie_cast
  has_many :cast, through: :movie_cast

  has_many :movie_genres
  has_many :genres, through: :movie_genres
  
  def as_json(options = {})
    super(options).merge({
      following_count: following.count,
      cast: {
        writer: handle_cast(movie_cast.writer),
        director: handle_cast(movie_cast.director),
        star: handle_cast(movie_cast.star)
      }
    })
  end

  def set_success(format, opts)
    self.success = true
  end

  private

    def handle_cast(association)
      association.as_json(include: [
        :cast => {
          only: [
            :id,
            :fullname
          ]
        }
      ], only: [])
    end
end
