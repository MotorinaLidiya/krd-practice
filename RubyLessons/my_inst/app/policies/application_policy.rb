class ApplicationPolicy < ActionPolicy::Base
  authorize :user, allow_nil: true

  def index?
    log_in?
  end

  def show?
    index?
  end

  def new?
    index?
  end

  def create?
    new?
  end

  def edit?
    index?
  end
    
  def update?
    edit?
  end

  def destroy?
    edit?
  end
  
  private

  def log_in?
    user.present?
  end
end
