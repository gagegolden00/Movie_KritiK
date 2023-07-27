class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: %i[show edit update destroy]

  # GET /movies or /movies.json
  def index
    get_available_genres
    get_available_years
    get_available_ratings

    # If the user gives a completely empty search
    if params.present? && params[:searched_terms] == "" && params[:searched_scores] == "0" && params.to_unsafe_h.count == 5
      @movies = Movie.includes(:review).all.order(title: :asc)
    # filtering the movies based on the search
    elsif params && params[:commit]&.[]("Search").present?
      searched_years = params[:searched_years].map(&:to_i) if params[:searched_years].present?      
      filtered_search = FilterSearch.new(params[:searched_terms], params[:searched_genres], searched_years, params[:searched_ratings], params[:searched_scores])
      @movies = filtered_search.execute_search
    # When no search is present
    else
      @movies = Movie.includes(:review).all.order(title: :asc)
    end
  end

  # GET /movies/1 or /movies/1.json
  def show
    @review = @movie.review
    if @movie.nil?
      redirect_to movies_url
    end
  end

  # GET /movies/new
  def new

    @movie = Movie.find(params[:movie_id])
    
  end

  # GET /movies/1/edit
  def edit
    @review = @movie.review
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)
    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    if @movie.destroy
      redirect_to movies_url, notice: "Movie was successfully destroyed."
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def filter_attribute_value(value)
    Array(value).reject(&:empty?)
  end

  # Only allow a list of trusted parameters through
  def movie_params
    params.permit(:searched_terms, searched_genres: [], searched_years: [], searched_ratings: [], searched_scores: [])
  end

  # set movie
  def set_movie
    @movie = Movie.find(params[:id])
  end

  # for finding genres
  def get_available_genres
    @avaliable_genres = Genre.pluck(:name).sort
  end

  # for finding & formatting years
  def get_available_years
    @movie_years = Movie.pluck(:start_year).uniq.sort
  end

  # for finding ratings
  def get_available_ratings
    @available_ratings = [
      "G", "PG", "PG-13", "R",
      "NC-17", "TV-Y", "TV-Y7",
      "TV-G", "TV-PG", "TV-14", "TV-MA",
      "N/A",
    ]
  end
end
