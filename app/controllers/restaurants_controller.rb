class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show]

  def index
    @restaurants = Restaurant.all
  end

  def show
    # Review
    # How to make it go back to home page from show page. it keeps asking for params
    if params[:id] == nil
      redirect_to restaurants_path
    else
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save
    redirect_to restaurant_path(@restaurant)
    # Review
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    @review.restaurant = @restaurant
    # if @review.save
    #   redirect_to restaurant_path(@restaurant)
    # else
    #   render :new
    # end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    # from create restaurants migration
    params.require(:restaurant).permit(:name, :address, :phone_number, :category)
  end
end
