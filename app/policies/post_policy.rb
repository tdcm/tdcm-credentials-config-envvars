class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user.has_role?(:admin)
        scope.all
      else
        scope.where.not(content: "")
      end
    end
  end

  def index?
    true
  end

  def new?
    true
    # @user.has_role?(:admin)
  end

  def show?
    true
  end

  def create?
    new?
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
