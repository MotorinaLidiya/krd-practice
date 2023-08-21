class ApplicationController < ActionController::Base
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
end
