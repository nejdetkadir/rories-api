class Cast < ApplicationRecord
  # validations
  validates_presence_of [:fullname, :biography, :image]
  validates_uniqueness_of [:fullname, :biography]

  # mounts
  mount_uploader :image, ImageUploader

  # relations
  has_many :user_following, as: :followable
  has_many :following, through: :user_following, source: :followable, source_type: "Cast"
end
