class ReviewsController < ApplicationController
  require 'net/http' # for api requests
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def search  
    retrieve_movie_list(params[:title])
    if @movie.nil? || @movie.empty?
      flash[:notice] = "Sorry, there are no movies that match your search."
    end
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
    @movie = retrieve_selected_movie_details(params[:movie_id])
  end
  

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    respond_to do |format|
      if @review.save
        format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
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
      params.require(:review).permit()
    end

    def retrieve_movies(title)
      @api_key = '6b86fd48'
      api_request = URI("http://www.omdbapi.com/?apikey=#{@api_key}&s=#{CGI.escape(title)}")
      response = Net::HTTP.get(api_request)
      JSON.parse(response)
    end

    def retrieve_movie_list(title)
      @movies = self.retrieve_movies(params[:title]) if params[:title].present?
    end

    def retrieve_selected_movie_details(movie_id)
      @api_key = '6b86fd48'
      api_request = URI("http://www.omdbapi.com/?apikey=#{@api_key}&i=#{CGI.escape(movie_id)}")
      response = Net::HTTP.get(api_request)
      JSON.parse(response)
    end
end
