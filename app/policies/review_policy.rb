class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end
  
  def new?
    true
  end

  def create?
    new?
  end

  def destroy
    true
  end
end
