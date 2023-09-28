class UserPolicy < ApplicationPolicy
  def profile?
    log_in?
  end

  def subscribe?
    log_in? && user != record && user.not_subscribed_to?(record)
  end

  def unsubscribe?
    log_in? && user != record && user.subscribed_to?(record)
  end

  def subscribtions?
    log_in?
  end
end
