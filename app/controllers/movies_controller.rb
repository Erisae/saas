class MoviesController < ApplicationController
  # attr_reader :all_ratings, :ratings_to_show
  # attr_writer :all_ratings, :ratings_to_show

  # @all_ratings = Movie.all_ratings #['G', 'R', 'PG-13', 'PG']
  # # a collection of which ratings should be checked, array
  # @ratings_to_show = [] # my

  def initialize
    # controller sets this variable by consulting the Model
    @all_ratings = Movie.all_ratings #['G', 'R', 'PG-13', 'PG']
    # a collection of which ratings should be checked, array
    @ratings_to_show = [] # my
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # how to figure out which boxes the user checked
    if params[:ratings] != nil
      @ratings_to_show = params[:ratings].keys
    else
      @ratings_to_show = []
    end
      # how to restrict the database query based on that result
    @movies = Movie.with_ratings(@ratings_to_show) # my
  end

  def new
    # default: render 'new' template
  end

  def create
    # not here
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

end

