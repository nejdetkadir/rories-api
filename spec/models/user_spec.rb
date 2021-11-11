require 'rails_helper'

RSpec.describe User, type: :model do
  it "should create a new instance given valid attributes" do
    model = described_class.new email: "test@example.com", password: "password"
    expect(model).to be_valid
  end

  it "should have a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is not valid without an email" do
    model = build(:user, email: nil, password: Faker::Internet.password(min_length: 6))
    expect(model).not_to be_valid
  end

  it "is not valid with different passwords" do
    model = build(:user, email: Faker::Internet.email, password: Faker::Internet.password(min_length: 6), password_confirmation: Faker::Internet.password(min_length: 8))
    expect(model).not_to be_valid
  end
end
