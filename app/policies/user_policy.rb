class UserPolicy < ApplicationPolicy
  def index?
    user.admin? # initially only admin can manage users
  end

  def show?
    index?
  end

  def create?
    index?
  end

  def new?
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
end
