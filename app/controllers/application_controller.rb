class ApplicationController < ActionController::API
  private

    def authenticate!
      unless current_user
        render json: { error: I18n.t('devise.failure.unauthenticated') }, status: :unauthorized
      end
    end

    def check_user_following(followable)
      user_signed_in? ? current_user.is_following?(followable) : false
    end
end
