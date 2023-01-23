class UserPolicy < ApplicationPolicy
  include Pundit::Authorization
  attr_reader :user, :record

  def initialize(user, record)
    fail Pundit::NotAuthorizedError, 'must be logged in' unless user
    @user = user
    @record = record
  end

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
