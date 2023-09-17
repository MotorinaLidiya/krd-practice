class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def alert_message(message)
    flash.now[:alert] = message
    render_flash
  end

  def success_message(message)
    flash.now[:notice] = message
    render_flash
  end

  private

  def render_flash
    turbo_stream.update('flash', partial: 'shared/flash')
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :first_name, :last_name])
  end
end
