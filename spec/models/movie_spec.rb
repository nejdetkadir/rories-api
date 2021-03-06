require 'rails_helper'

RSpec.describe Movie, type: :model do
  it "should create a new instance given valid attributes" do
    model = described_class.new(
      title: "The Fast and the Furious: Tokyo Drift",
      storyline: "A teenager becomes a major competitor in the world of drift racing after moving in with his father in Tokyo to avoid a jail sentence in America.",
      cover: File.open(Rails.root.join("spec", "fixtures", "files", "images", "placeholder.png")),
      trailer: File.open(Rails.root.join("spec", "fixtures", "files", "videos", "placeholder.mp4")),
      imdb_id: "tt0463985",
      imdb_rating: 6.0,
      minutes: 104,
      minimum_age: 7,
      released_at: 2006
    )
    expect(model).to be_valid
  end

  it "should have a valid factory" do
    expect(build(:movie)).to be_valid
  end

  it "is not valid without a title" do
    model = build(:movie, title: nil)
    expect(model).not_to be_valid
  end

  it "is not valid without a storyline" do
    model = build(:movie, storyline: nil)
    expect(model).not_to be_valid
  end

  it "is not valid without a cover" do
    model = build(:movie, cover: nil)
    expect(model).not_to be_valid
  end

  it "is valid without a trailer" do
    model = build(:movie, trailer: nil)
    expect(model).to be_valid
  end

  it "is not valid without an imdb id" do
    model = build(:movie, imdb_id: nil)
    expect(model).not_to be_valid
  end

  it "should have a unique imdb id" do
    model = build(:movie, imdb_id: create(:movie).imdb_id)
    expect(model).not_to be_valid
  end

  it "is not valid without a imdb rating" do
    model = build(:movie, imdb_rating: nil)
    expect(model).not_to be_valid
  end

  it "is not valid without a minutes" do
    model = build(:movie, minutes: nil)
    expect(model).not_to be_valid
  end

  it "is not valid without a released at" do
    model = build(:movie, released_at: nil)
    expect(model).not_to be_valid
  end

  it "is valid without a trailer" do
    model = build(:movie, trailer: nil)
    expect(model).to be_valid
  end

  it "is valid without a minimum age" do
    model = build(:movie, minimum_age: nil)
    expect(model).to be_valid
  end

  it "should have many following" do
    model = described_class.reflect_on_association(:user_following)
    expect(model.macro).to eq(:has_many)
  end

  it "should have many cast" do
    model = described_class.reflect_on_association(:movie_cast)
    expect(model.macro).to eq(:has_many)
  end

  it "should have many genres" do
    model = described_class.reflect_on_association(:movie_genres)
    expect(model.macro).to eq(:has_many)
  end

  it "should have not same genre" do
    model = create(:movie_genre, movie: create(:movie))
    expect(model.dup).not_to be_valid
  end
end
