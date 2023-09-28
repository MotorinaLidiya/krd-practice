class PostPolicy < ApplicationPolicy
  def edit?
    user == record.author
  end
end
