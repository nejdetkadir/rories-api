require 'rails_helper'

RSpec.describe "Genres", type: :request do

  describe "GET /index" do
    before { get genres_path }

    it "returns status code 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns all genres" do
      expect(JSON.parse(response.body).size).to eq(Genre.count)
    end
  end

  describe "GET /:id" do
    before { get genre_path(create(:genre)) }

    it "returns status code 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns all movies of genre" do
      expect(JSON.parse(response.body).size).to eq(0)
    end
  end
end
