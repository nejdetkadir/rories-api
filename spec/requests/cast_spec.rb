require 'rails_helper'

RSpec.describe "Cast", type: :request do
  describe "GET /show" do
    before { get cast_path(create(:cast)) }

    it "returns status code 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns a cast with associations" do
      expect(JSON.parse(response.body)["id"]).to eq(request.params[:id])
    end
  end
end
