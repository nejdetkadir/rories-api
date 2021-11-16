require 'rails_helper'

RSpec.describe "Devise::Registrations", type: :request do
  before {
    @headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  }

  describe "POST /users" do
    describe "with unique email/password" do
      before {
        post user_registration_path, params: {
          user: {
            email: Faker::Internet.email,
            password: "123456789",
            password_confirmation: "123456789"
          }
        }.to_json, headers: @headers
      }

      it "returns status code 201" do
        expect(response).to have_http_status(:created)
      end

      it "returns authorization bearer token on headers" do
        expect(response.headers["Authorization"]).not_to eq(nil)
      end
    end

    describe "with different passwords" do
      before {
        post user_registration_path, params: {
          user: {
            email: Faker::Internet.email,
            password: "123456789",
            password_confirmation: "!123456789!"
          }
        }.to_json, headers: @headers
      }

      it "returns status code 401" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns errors of resource" do
        expect(JSON.parse(response.body)["password_confirmation"]).not_to eq(nil)
      end
    end

    describe "with same email" do
      before {
        post user_registration_path, params: {
          user: {
            email: create(:user).email,
            password: "123456789",
            password_confirmation: "123456789"
          }
        }.to_json, headers: @headers
      }

      it "returns status code 401" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns errors of resource" do
        expect(JSON.parse(response.body)["email"]).not_to eq(nil)
      end
    end
  end
end
