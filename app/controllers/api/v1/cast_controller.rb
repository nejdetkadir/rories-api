class Api::V1::CastController < Api::V1::FollowableController
  before_action :set_cast, only: [:show]
  before_action :set_cast_for_followable, only: [:follow, :unfollow]

  def show
    render json: @cast.as_json(except: [
      :created_at,
      :updated_at]
    ).merge({
      is_following: current_user.is_following?(@cast)
    }), status: :ok
  end

  def follow
    super @cast
  end

  def unfollow
    super @cast
  end

  private

    def set_cast_for_followable
      @cast = Cast.find(params[:cast_id])
    end

    def set_cast
      @cast = Cast.find(params[:id])
    end
end
