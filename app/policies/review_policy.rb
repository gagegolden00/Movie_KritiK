class ReviewPolicy < ApplicationPolicy
  attr_reader :user, :review

  def initialize(user, review)
    @user = user
    @review = review
  end

  def search?
    only_admin
  end

  def create?
    only_admin
  end

  def new?
    create?
  end

  def update?
    only_admin
  end

  def edit?
    only_admin
  end

  def destroy?
    only_admin
  end

  private

  def only_admin
    @user.present?
    @user.admin?
  end
end
