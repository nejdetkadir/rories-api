require 'rails_helper'

RSpec.describe Cast, type: :model do
  it "should create a new instance given valid attributes" do
    model = described_class.new(
      fullname: "Johnny Depp",
      biography: "John Christopher Depp II is an American actor, producer, and musician.",
      remote_image_url: Faker::LoremPixel.image
    )
    expect(model).to be_valid
  end

  it "should have a valid factory" do
    expect(build(:cast)).to be_valid
  end

  it "is not valid without a fullname" do
    model = build(:cast, fullname: nil)
    expect(model).not_to be_valid
  end

  it "should have a unique fullname" do
    model = create(:cast, fullname: "Example")
    expect(model.dup).not_to be_valid  
  end

  it "is not valid without a biography" do
    model = build(:cast, biography: nil)
    expect(model).not_to be_valid
  end

  it "should have a unique biography" do
    model = create(:cast, biography: "Example")
    expect(model.dup).not_to be_valid  
  end

  it "is not valid without an image" do
    model = build(:cast, image: nil)
    expect(model).not_to be_valid
  end  
end
