class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def edit?
    @user.has_any_role? :admin, :moderator
    # index?
  end

  def update?
    edit?
  end
end
