class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  # relations
  has_many :user_following
  has_many :following_cast, through: :user_following, source: :followable, source_type: "Cast"
  has_many :following_genres, through: :user_following, source: :followable, source_type: "Genre"
  has_many :following_movies, through: :user_following, source: :followable, source_type: "Movie"

  def is_following?(followable)
    self.user_following.exists?(followable: followable)
  end

  def follow(followable)
    self.user_following.create(followable: followable)
  end

  def unfollow(followable)
    self.user_following.find_by(followable: followable).destroy if self.is_following?(followable)
  end

  def following_ids
    {
      movie_ids: self.following_movies.ids,
      genre_ids: self.following_genres.ids,
      cast_ids: self.following_cast.ids
    }
  end
end
