class MoviesController < ApplicationController
  attr_reader :all_ratings, :ratings_to_show
  attr_writer :all_ratings, :ratings_to_show
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # @movies = Movie.all
    # how to figure out which boxes the user checked
    @ratings_to_show = []
    params[:ratings].each { |key, value| @ratings_to_show.push(key) if value==1}
    # how to restrict the database query based on that result
    @movies = Movie.with_ratings(@ratings_to_show) # my
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    # controller sets this variable by consulting the Model
    @all_ratings = Movie.all_ratings # my
    # a collection of which ratings should be checked, array
    @ratings_to_show = [] # my
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
