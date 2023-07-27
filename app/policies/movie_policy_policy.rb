class MoviePolicy < ApplicationPolicy
  attr_reader :user, :movie

  def initialize(user, movie)
    @user = user
    @movie = movie
  end
  def index?
    true
  end

  def show?
    true
  end

  def create?
    only_admin
  end

  def new?
    only_admin
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
    @user.admin?
  end
end

