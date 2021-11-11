class Genre < ApplicationRecord
  # validations
  validates_presence_of :name
  validates_uniqueness_of :name
end
