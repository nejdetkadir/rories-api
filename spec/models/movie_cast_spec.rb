require 'rails_helper'

RSpec.describe MovieCast, type: :model do
  it "should have a valid factory" do
    expect(build(:movie_cast)).to be_valid
  end
end
