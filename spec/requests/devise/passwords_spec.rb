require 'rails_helper'

RSpec.describe "Devise::Passwords", type: :request do
  before {
    @headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    @user = create(:user, email: "nejdetkadir.550@gmail.com")
  }

  describe "POST /password" do
    describe "with valid email" do
      before {
        reset_password_with_email
      }

      it "returns status code 200" do
        expect(response).to have_http_status(:ok) 
      end

      it "returns a message about instructions" do
        expect(JSON.parse(response.body)["message"]).to eq(I18n.t('devise.confirmations.send_instructions')) 
      end

      it "should send an email about instructions of reset password" do
        expect(Devise.mailer.deliveries.count).to eq(1)
      end
    end

    describe "with invalid email" do
      before {
        post user_password_path, params: {
          user: {
            email: Faker::Internet.email
          }
        }.to_json, headers: @headers
      }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity) 
      end

      it "should not send an email about instructions of reset password" do
        expect(Devise.mailer.deliveries.count).to eq(0)
      end
    end
  end

  describe "PATCH /password" do
    describe "with valid reset password token" do
      before {
        reset_password_with_email

        patch user_password_path, params: {
          user: {
            reset_password_token: crawl_reset_password_token_from_email,
            password: "123456789",
            password_confirmation: "123456789"
          }
        }.to_json, headers: @headers
      }

      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end
    end

    describe "with invalid reset password token" do
      before {
        reset_password_with_email

        patch user_password_path, params: {
          user: {
            reset_password_token: "!#{crawl_reset_password_token_from_email}!",
            password: "123456789",
            password_confirmation: "123456789"
          }
        }.to_json, headers: @headers
      }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe "with different passwords" do
      before {
        reset_password_with_email

        patch user_password_path, params: {
          user: {
            reset_password_token: "!#{crawl_reset_password_token_from_email}!",
            password: Faker::Internet.password(min_length: 8),
            password_confirmation: Faker::Internet.password(min_length: 8)
          }
        }.to_json, headers: @headers
      }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
  def reset_password_with_email
    post user_password_path, params: {
      user: {
        email: @user.email
      }
    }.to_json, headers: @headers
  end

  def crawl_reset_password_token_from_email
    Devise.mailer.deliveries.last.as_json["body"]["raw_source"].split("reset_password_token=").last.split('">').first
  end
end
