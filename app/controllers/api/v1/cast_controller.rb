class Api::V1::CastController < ApplicationController
  before_action :set_cast, only: [:show]

  def show
    render json: @cast, status: :ok, except: [
      :created_at,
      :updated_at
    ]
  end

  private

    def set_cast
      @cast = Cast.find(params[:id])
    end
end
