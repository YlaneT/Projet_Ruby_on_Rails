class ReservationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?

    if user.admin or record.user == user
      true
    else
      false
    end
      
    
  end

  def new?
    true
  end

  def create?
    new?
  end

  def edit?
    if user.admin or record.user == user
      true
    else
      false
    end
  end

  def update?
    edit?
  end

  def destroy?
    if user.admin or record.user == user
      true
    else
      false
    end
  end
end
