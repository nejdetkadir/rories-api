require 'rails_helper'

RSpec.describe Genre, type: :model do
  it "should create a new instance given valid attributes" do
    model = described_class.new name: "Horror"
    expect(model).to be_valid
  end

  it "should have a valid factory" do
    expect(build(:genre)).to be_valid
  end

  it "is not valid without a name" do
    model = build(:genre, name: nil)
    expect(model).not_to be_valid
  end

  it "should have a unique name" do
    model = create(:genre)
    expect(model.dup).not_to be_valid  
  end
end
