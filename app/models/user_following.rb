class UserFollowing < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :followable, polymorphic: true

  # validations
  validates :user, uniqueness: { scope: %i[followable_id followable_type] }

  # custom callbacks
  before_save :check_following_type

  def check_following_type
    errors.add(:user, "can follow only cast, movies or genres") if !can_be_follow.include?(self.followable_type)
  end

  def can_follow
    ["Cast", "Movie", "Genre"]
  end
end
