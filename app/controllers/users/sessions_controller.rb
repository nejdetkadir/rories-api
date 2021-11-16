class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: resource, status: resource.id.nil? ? :unauthorized : :ok
  end

  def respond_to_on_destroy
    render json: {}, status: :no_content
  end
end