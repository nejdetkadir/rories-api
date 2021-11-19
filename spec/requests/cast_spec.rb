require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Cast", type: :request do
  before {
    @user = create(:user)
    @headers = Devise::JWT::TestHelpers.auth_headers({ 
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }, @user)
  }

  describe "GET /show" do
    before { get cast_path(create(:cast)), headers: @headers }

    it "returns status code 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns a cast with associations" do
      expect(JSON.parse(response.body)["id"]).to eq(request.params[:id])
    end
  end

  describe "GET /:id/follow" do
    before {
      @cast = create(:cast)
    }

    describe "follow first time" do
      before {
        post cast_follow_path(@cast), headers: @headers
      }

      it "returns status code 201" do
        expect(response).to have_http_status(:created)
      end
    end

    describe "follow second timme" do
      before {
        @user.follow(@cast)
        post cast_follow_path(@cast), headers: @headers
      }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
