class PostPolicy < ApplicationPolicy
  def profile?
    index?
  end
end
