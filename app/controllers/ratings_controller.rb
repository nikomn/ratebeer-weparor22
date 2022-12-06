class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    # binding.pry
    rating = Rating.create params.require(:rating).permit(:score, :beer_id)
    # Rating.create params.require(:rating).permit(:score, :beer_id)
    session[:last_rating] = "#{rating.beer.name} #{rating.score} points"
    redirect_to ratings_path
    # redirect_to "http://www.cs.helsinki.fi"
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path
  end
end
