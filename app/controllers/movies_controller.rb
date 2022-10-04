class MoviesController < ApplicationController
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    # order
    if params[:clicking] != nil
      if params[:clicking][:movie_title] == "1"
        @reorder = :title
      elsif params[:clicking][:release_date] == "1"
        @reorder = :release_date
      end
    end

    aFile = File.new("/home/codio/workspace/input.txt", "w")
    if aFile
      aFile.syswrite(@reorder)
      aFile.syswrite(@ratings_to_show)
      aFile.syswrite("========")
    end

    # how to figure out which boxes the user checked
    if params[:ratings] != nil
      @ratings_to_show = params[:ratings].keys
    else
      @ratings_to_show = []
    end
    # how to restrict the database query based on that result
    @movies = Movie.order(@reorder).with_ratings(@ratings_to_show) # my
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

