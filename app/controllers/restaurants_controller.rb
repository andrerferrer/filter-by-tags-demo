class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @restaurants = tagged_restaurants(@restaurants) if params[:tag_id]
  end

  def show
    set_restaurant
    @review = Review.new
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new strong_params
    @restaurant.save ? redirect_to(@restaurant) : render(:new)
  end

  def destroy
    set_restaurant
    @restaurant.destroy
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def strong_params
    params.require(:restaurant).permit(Restaurant::STRONG_PARAMS)
  end

  def tagged_restaurants(restaurants)
    restaurants.joins(:restaurant_tags)
               .joins(:tags)
               .where('tags.id = ?', params[:tag_id])
  end
end
