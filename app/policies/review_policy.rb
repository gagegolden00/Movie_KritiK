class ReviewPolicy < ApplicationPolicy
  attr_reader :user, :review
  def initialize(user, review)
    @user = user
    @review = review
  end
  
  def index?
    true
  end
  
  def show?
    true
  end
  
  def create?
    binding.pry
    only_admin
  end
  def new?
    create?
  end
  
  def update?
    only_admin
  end
  def edit?
    update?
  end
  
  def destroy?
    only_admin
  end
  
  private
  def only_admin
    @user.admin?
  end
end