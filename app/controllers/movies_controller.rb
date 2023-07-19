class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: %i[show edit update destroy]
  # GET /movies or /movies.json
  def index
    get_available_genres
    get_available_years
    get_available_ratings
    @movies = Movie.includes(:review)
    if params.to_unsafe_h.length > 3
      @movies = Movie.search_by_title(params[:searched_title]).search_by_genre(params[:searched_genre]).search_by_year(params[:searched_year]).search_by_rating(params[:searched_rating]).search_by_score(params[:searched_score])
      if @movies.nil?
      end
    else
      @movies = Movie.includes(:review).all
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
    params.require(:movie).permit(:searched_title, :searched_year, :searched_genre, :searched_rating, :searched_score)
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
    @movie_years = Movie.pluck(:year).sort
    @formatted_avaliable_years = []
    @movie_years.map do |year|
      truncated_year = year.slice(0, 4)
      @formatted_avaliable_years << truncated_year
      @earliest_year = @formatted_avaliable_years.first
      @latest_year = @formatted_avaliable_years.last
      #binding.pry
    end
    @formatted_avaliable_years.uniq!
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
