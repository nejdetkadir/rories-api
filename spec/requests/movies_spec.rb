require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Movies", type: :request do
  before {
    @user = create(:user)
    @headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  }

  describe "GET /index" do
    before { get movies_path }

    it "returns status code 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns movies" do
      expect(JSON.parse(response.body).size).to eq(0)
    end
  end

  describe "GET /:id" do
    before { get movie_path(create(:movie)) }

    it "returns status code 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns a movie with associations" do
      expect(JSON.parse(response.body)["id"]).to eq(request.params[:id])
    end
  end

  describe "GET /:id/follow" do
    before {
      @movie = create(:movie)
    }

    describe "follow first time" do
      before {
        post movie_follow_path(@movie), headers: Devise::JWT::TestHelpers.auth_headers(@headers, @user)
      }

      it "returns status code 201" do
        expect(response).to have_http_status(:created)
      end
    end

    describe "follow second timme" do
      before {
        @user.follow(@movie)
        post movie_follow_path(@movie), headers: Devise::JWT::TestHelpers.auth_headers(@headers, @user)
      }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
