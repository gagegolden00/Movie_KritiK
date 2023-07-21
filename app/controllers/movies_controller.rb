class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: %i[show edit update destroy]

  # GET /movies or /movies.json
  def index
    get_available_genres
    get_available_years
    get_available_ratings

    # if the user gives a completely empty search
    if params.present? && params[:searched_terms] == "" && params[:searched_scores] == "0" && params.to_unsafe_h.count == 5
      @movies = Movie.includes(:review).all.order(title: :asc)

      # filtering the movies based on the search
    elsif params && params[:commit]&.[]("Search").present?
      # @movies = Movie.search_by_term(params[:searched_terms])
      # @movies = Movie.search_by_genre(params[:searched_genres])
      # @movies = Movie.search_by_year(params[:searched_years])
      # @movies = Movie.search_by_rating(params[:searched_ratings])
      # @movies = Movie.search_by_score(params[:searched_scores])
      #@movies = Movie.search_by_term(params[:searched_terms])
      #@movies.each {|movie| puts movie.title}
      #binding.pry
      #@movies = @movies.search_by_genre(params[:searched_genres])
      #@movies.each {|movie| puts movie.title}
      #binding.pry
      #@movies = @movies.search_by_year(params[:searched_years])
      #@movies.each {|movie| puts movie.title}
      #binding.pry
      #@movies = @movies.search_by_rating(params[:searched_ratings])
      #@movies.each {|movie| puts movie.title}
      #binding.pry
      #@movies = @movies.search_by_score(params[:searched_scores])
      #@movies.each {|movie| puts movie.title}
      #binding.pry

      @movies = Movie.all

      # Search by term if 'searched_terms' param is present
      if params[:searched_terms].present?
        @movies = @movies.search_by_term(params[:searched_terms])
        #binding.pry
      end

      # Search by genre if 'searched_genres' param is present
      if params[:searched_genres].present?
        @movies = @movies.search_by_genre(params[:searched_genres])
        #binding.pry
      end

      # Search by year if 'searched_years' param is present
      if params[:searched_years].present?
        @movies = @movies.search_by_year(params[:searched_years])
        #binding.pry
      end

      # Search by rating if 'searched_ratings' param is present
      if params[:searched_ratings].present?
        @movies = @movies.search_by_rating(params[:searched_ratings])
        #binding.pry
      end

      # Search by score if 'searched_scores' param is present
      if params[:searched_scores].present?
        @movies = @movies.search_by_score(params[:searched_scores])
        #binding.pry
      end

      # At this point, the @movies variable should contain the final filtered result based on the params.
      # You can continue with any further processing or display the movies as needed.
      @movies.each { |movie| puts movie.title }
    else
      # for the landing to display all movies
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
    @movie_years = Movie.pluck(:year).sort
    @formatted_avaliable_years = []
    @movie_years.map do |year|
      truncated_year = year.slice(0, 4)
      @formatted_avaliable_years << truncated_year
      @earliest_year = @formatted_avaliable_years.first
      @latest_year = @formatted_avaliable_years.last
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
