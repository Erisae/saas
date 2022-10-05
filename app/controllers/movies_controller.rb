class MoviesController < ApplicationController
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    # if no params and not first
    if params[:clicking]==nil and params[:ratings]==nil and params[:home]=="1"
      if session[:reorder] == "title"
        clicking_v = {:movie_title=>"1", :release_date=>"0"}
      elsif session[:reorder] == "release_date"
        clicking_v = {:movie_title=>"0", :release_date=>"1"}
      end

      if session[:ratings] != nil
        rating_v = Hash[session[:ratings].map {|v| [v,1]}]
      end
      
      redirect_to movies_path({:clicking=>clicking_v, :ratings=>rating_v})
    end

    # order
    if params[:clicking] != nil
      if params[:clicking][:movie_title] == "1"
        @reorder = :title
      elsif params[:clicking][:release_date] == "1"
        @reorder = :release_date
      end
      session[:reorder] = @reorder
    end

    # how to figure out which boxes the user checked
    if params[:ratings] != nil
      @ratings_to_show = params[:ratings].keys
      session[:ratings] = @ratings_to_show
    else
      @ratings_to_show = @all_ratings
    end

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

