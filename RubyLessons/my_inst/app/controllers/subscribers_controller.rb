class SubscribersController < ApplicationController
  before_action :set_user

  def create
    current_user.subscribe_to(@user_to_subscribe)
    redirect_to @user, notice: 'You are now subscribed.'
  end

  def destroy
    current_user.unsubscribe_from(@user_to_unsubscribe)
    redirect_to @user, notice: 'You have unsubscribed.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
