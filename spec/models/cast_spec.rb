require 'rails_helper'

RSpec.describe Cast, type: :model do
  it "should create a new instance given valid attributes" do
    model = described_class.new(
      fullname: "Johnny Depp",
      biography: "John Christopher Depp II is an American actor, producer, and musician.",
      image: File.open(Rails.root.join("spec", "fixtures", "files", "images", "placeholder.png"))
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

  it "is valid without an image" do
    model = build(:cast, image: nil)
    expect(model).to be_valid
  end

  it "should have many following" do
    model = described_class.reflect_on_association(:user_following)
    expect(model.macro).to eq(:has_many)
  end

  it "should have many movies" do
    model = described_class.reflect_on_association(:movie_cast)
    expect(model.macro).to eq(:has_many)
  end

  it "can not to be same role in a movie" do
    model = create(:movie_cast, cast: create(:cast), movie: create(:movie))
    expect(model.dup).not_to be_valid
  end
end
