class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  # relations
  has_many :user_following
  has_many :following, through: :user_following, source: :user

  def is_following?(followable)
    self.user_following.exists?(followable: followable)
  end

  def follow(followable)
    self.user_following.create(followable: followable)
  end

  def unfollow(followable)
    self.user_following.find_by(followable: followable).destroy if self.is_following?(followable)
  end
end
