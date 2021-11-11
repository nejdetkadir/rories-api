class Cast < ApplicationRecord
  # validations
  validates_presence_of [:fullname, :biography, :image]
  validates_uniqueness_of [:fullname, :biography]

  # mounts
  mount_uploader :image, ImageUploader
end
