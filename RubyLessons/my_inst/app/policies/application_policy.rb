class ApplicationPolicy < ActionPolicy::Base
  authorize :user, allow_nil: true

  def index?
    log_in?
  end

  def new?
    index?
  end

  def create?
    index?
  end

  def edit?
    index?
  end
    
  def update?
    index?
  end

  def destroy?
    index?
  end
  
  private

  def log_in?
    user.present?
  end
end
