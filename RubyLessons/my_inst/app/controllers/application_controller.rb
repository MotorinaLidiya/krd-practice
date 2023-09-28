class ApplicationController < ActionController::Base
  rescue_from ActionPolicy::Unauthorized do
    redirect_to root_path, alert: 'You are not authorized for this action.'
  end
end
