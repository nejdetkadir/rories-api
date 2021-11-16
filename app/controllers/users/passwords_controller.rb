class Users::PasswordsController < Devise::PasswordsController
  respond_to :json
  # prepend_before_action :require_no_authentication
  # Render the #edit only if coming from a reset password email link
  # append_before_action :assert_reset_token_passed, only: :edit

  # GET /resource/password/new
  # def new
  #   self.resource = resource_class.new
  # end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({ message: I18n.t('devise.confirmations.send_instructions') }, :ok)
    else
      respond_with resource.errors, :unprocessable_entity
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   self.resource = resource_class.new
  #   set_minimum_password_length
  #   resource.reset_password_token = params[:reset_password_token]
  # end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      respond_with resource, :ok
    else
      set_minimum_password_length
      respond_with resource.errors, :unprocessable_entity
    end
  end

  # protected
    # def after_resetting_password_path_for(resource)
    #   Devise.sign_in_after_reset_password ? after_sign_in_path_for(resource) : new_session_path(resource_name)
    # end

    # The path used after sending reset password instructions
    # def after_sending_reset_password_instructions_path_for(resource_name)
    #   new_session_path(resource_name) if is_navigational_format?
    # end

    # Check if a reset_password_token is provided in the request
    # def assert_reset_token_passed
    #   if params[:reset_password_token].blank?
    #     set_flash_message(:alert, :no_token)
    #     redirect_to new_session_path(resource_name)
    #   end
    # end

    # Check if proper Lockable module methods are present & unlock strategy
    # allows to unlock resource on password reset
    # def unlockable?(resource)
    #   resource.respond_to?(:unlock_access!) &&
    #     resource.respond_to?(:unlock_strategy_enabled?) &&
    #     resource.unlock_strategy_enabled?(:email)
    # end

    # def translation_scope
    #   'devise.passwords'
    # end

    private

      def respond_with(content, status)
        render json: content, status: status
      end
end