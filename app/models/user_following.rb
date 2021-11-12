class UserFollowing < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :followable, polymorphic: true

  # validations
  validates :user, uniqueness: { scope: %i[followable_id followable_type] }
end
