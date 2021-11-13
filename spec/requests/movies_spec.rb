require 'rails_helper'

RSpec.describe "Movies", type: :request do
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
end
