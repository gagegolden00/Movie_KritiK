class ApplicationController < ActionController::Base
  before_action :set_movie, only: %i[show edit update destroy]

    include Pundit::Authorization
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    
    private
    def user_not_authorized
      flash[:alert] = "Sorry you dont have the proper permissions to perform this action"
      redirect_to root_path
    end
    def set_movie
      @movie = Movie.find(params[:id]) if @movie.present?
    end
end
