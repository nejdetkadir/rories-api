class Cast < ApplicationRecord
  # validations
  validates_presence_of [:fullname, :biography]
  validates_uniqueness_of [:fullname]

  # mounts
  mount_uploader :image, ImageUploader

  # relations
  has_many :user_following, as: :followable
  has_many :following, through: :user_following, source: :followable, source_type: "Cast"
  
  has_many :movie_cast
  has_many :movies, through: :movie_cast

  def as_json(options = {})
    super(options).merge({
      following_count: following.count,
      roles: {
        writer: handle_role(movie_cast.writer),
        director: handle_role(movie_cast.director),
        star: handle_role(movie_cast.star)
      }
    })
  end

  private

    def handle_role(association)
      association.as_json(include: [
        :movie => {
          only: [:id, :title],
          include: [
            :genres => {
              only: [:id, :name]
            }
          ]
        }
      ], only: [])
    end
end
