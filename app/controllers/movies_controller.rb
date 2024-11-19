class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    id = params[:id]
    @movies = Movie.find(id)
  end

  def new
    @movies = Movie.new
  end

  def create
    if (@movies = Movie.create(movie_params))
      redirect_to movies_path, :notice => "#{@movies.title} created."
    else
      flash[:alert] = "Movie #{@movies.title} could not be created: " +
        @movies.errors.full_messages.join(",")
      render 'new'
    end
  end

  def edit
    @movies = Movie.find params[:id]
  end

  def update
    @movies = Movie.find params[:id]
    if (@movies.update_attributes(movie_params))
      redirect_to movies_path(@movies), :notice => "#{@movies.title} updated."
    else
      flash[:alert] = "#{@movies.title} could not be updated: " +
        @movies.errors.full_messages.join(",")
      render 'edit'
    end
  end

  def destroy
    @movies = Movie.find(params[:id])
    @movies.destroy
    redirect_to movies_path, :notice => "#{@movies.title} deleted."
  end

  private
  def movie_params
    params.require(:movie)
    params[:movie].permit(:title,:rating,:release_date)
  end
end