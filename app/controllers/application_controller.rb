class ApplicationController < ActionController::API
  private

    def authenticate!
      unless current_user
        render json: { error: I18n.t('devise.failure.unauthenticated') }, status: :unauthorized
      end
    end
end
