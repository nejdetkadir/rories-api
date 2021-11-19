require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Genres", type: :request do
  before {
    @user = create(:user)
    @headers = Devise::JWT::TestHelpers.auth_headers({ 
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }, @user)
  }

  describe "GET /index" do
    before { get genres_path, headers: @headers }

    it "returns status code 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns all genres" do
      expect(JSON.parse(response.body).size).to eq(Genre.count)
    end
  end

  describe "GET /:id" do
    before { get genre_path(create(:genre)), headers: @headers }

    it "returns status code 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns all movies of genre" do
      expect(JSON.parse(response.body).size).to eq(0)
    end
  end

  describe "GET /:id/follow" do
    before {
      @genre = create(:genre)
    }

    describe "follow first time" do
      before {
        post genre_follow_path(@genre), headers: @headers
      }

      it "returns status code 201" do
        expect(response).to have_http_status(:created)
      end
    end

    describe "follow second timme" do
      before {
        @user.follow(@genre)
        post genre_follow_path(@genre), headers: @headers
      }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
