class Api::V1::FollowableController < ApiController
  def follow(followable)
    @followable = current_user.follow(followable)

    if @followable.persisted?
      render json: @followable, status: :created, only: [
        :id
      ]
    else
      render json: @followable.errors, status: :unprocessable_entity
    end
  end

  def unfollow(followable)
    current_user.unfollow(followable)

    render json: {}, status: :no_content
  end
end