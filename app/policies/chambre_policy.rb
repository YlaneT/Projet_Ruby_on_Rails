class ChambrePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    if user.admin
      true
    else
      false
    end
  end

  def create?
    new?
  end

  def edit?
    if user.admin
      true
    else
      false
    end
  end

  def update?
    edit?
  end

  def destroy?
    if user.admin
      true
    else
      false
    end
  end
end
