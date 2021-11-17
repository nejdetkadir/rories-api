class Api::V1::CastController < Api::V1::FollowableController
  before_action :set_cast, only: [:show]
  before_action :set_cast_for_followable, only: [:follow, :unfollow]

  def show
    @cast = @cast.as_json.merge({
      is_following: true
    }) if check_user_following(@cast)

    render json: @cast, status: :ok, except: [
      :created_at,
      :updated_at
    ]
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
