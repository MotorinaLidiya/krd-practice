class ApplicationController < ActionController::Base
  rescue_from ActionPolicy::Unauthorized do |ex|
    render 'home/no_access'
  end
end
