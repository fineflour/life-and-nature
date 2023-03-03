class ProductPolicy < ApplicationPolicy
  include Pundit::Authorization
  def index?
    if user.admin? # initially only admin can manage users
#      scope.all
      #index?
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

    def scope
      record.class
    end

  end
end
