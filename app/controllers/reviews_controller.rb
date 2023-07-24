class ReviewsController < ApplicationController
  require "net/http" # for api requests
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def search

    #authorize @review
    retrieve_movie_list(params[:title])
    @search_performed = !params[:title].nil?
    @exsisting_movies_with_api_movie_id = Review.joins(:movie).select("reviews.api_movie_id, reviews.movie_id")
  end

  # GET /reviews or /reviews.json
  def index
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
    authorize @review
    @movie_data = retrieve_selected_movie_details(params[:api_movie_id])
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new
    authorize @review
    ActiveRecord::Base.transaction do
      if params[:review][:api_movie_id].present?
        movie_data_hash = retrieve_selected_movie_details(params[:review][:api_movie_id])
        # create genre
        genres = GenreCreator.create_genre(movie_data_hash)
        # create movie
        movie = MovieCreator.create_movie(movie_data_hash, genres)
      else
        notice "The movie you selected or the necessary details do not exist. Please try again."
      end

      @review = Review.new(review_params)
      @review.movie_id = movie.id

      respond_to do |format|
        if @review.save
          format.html { redirect_to movie_path(@review.movie), notice: "Review was successfully created." }
        else
          format.turbo_stream {
            render turbo_stream: turbo_stream.replace(
              "error_messages",
              partial: "devise/shared/error_messages",
            )
          }
        end
      end
      raise ActiveRecord::Rollback if @review.id.nil?
    end
  end

  # GET /reviews/1/edit
  def edit
    @movie = @review.movie
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    @movie = @review.movie
    if @review.update(review_params)
      redirect_to @movie
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:content, :score, :api_movie_id)
  end

  def retrieve_movies(title)
    @api_key = "6b86fd48"
    api_request = URI("http://www.omdbapi.com/?apikey=#{@api_key}&s=#{CGI.escape(title)}")
    response = Net::HTTP.get(api_request)
    JSON.parse(response)
  end

  def retrieve_movie_list(title)
    @movies = self.retrieve_movies(params[:title]) if params[:title].present?
  end

  def retrieve_selected_movie_details(api_movie_id)
    @api_key = "6b86fd48"
    api_request = URI("http://www.omdbapi.com/?apikey=#{@api_key}&i=#{CGI.escape(api_movie_id)}") if api_movie_id.present?
    response = Net::HTTP.get(api_request)
    JSON.parse(response)
  end
end
