class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: %i[show edit update destroy]
  

  # GET /movies or /movies.json
  def index
    @movies = Movie.all
    @movie = Movie.new
    if params[:movie].present?
      @params_array = params[:movie].transform_values do |value|
        Array(value).reject(&:empty?) unless Array(value).empty?
      end.compact.select { |_key, value| value.present? }
    end
    params = @params_array
    if params && params[:movie].present?
      @movies = @movies.filter_movies(params[:movie]) 
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
      params.require(:movie).permit(:title, :year, :genre, :rating, :score)
    end

    
    def set_movie
      @movie = Movie.find(params[:id])
    end

end
