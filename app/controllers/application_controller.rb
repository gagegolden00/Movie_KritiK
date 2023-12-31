class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Sorry you dont have the proper permissions to perform this action"
    redirect_to root_path
  end
end
