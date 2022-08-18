class BookingPolicy < ApplicationPolicy

  class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    true
  end

  def show?
    record.user == user
  end

  def update?
    record.user == user || record.offer.user == user
  end
end
