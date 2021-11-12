require 'rails_helper'

RSpec.describe UserFollowing, type: :model do
  it "should have a valid factory" do
    expect(build(:user_following)).to be_valid
  end
end
