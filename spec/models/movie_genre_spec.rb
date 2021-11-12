require 'rails_helper'

RSpec.describe MovieGenre, type: :model do
  it "should have a valid factory" do
    expect(build(:movie_genre)).to be_valid
  end
end
