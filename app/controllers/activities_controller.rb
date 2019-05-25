class ActivitiesController < ApplicationController
  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user = current_user
    @activity.distance = calculate_distance()
    if @activity.save
      flash[:success] = "You have just added a new activity!"
      redirect_to @activity
    else
      render 'new'
    end
  end

  def show
  end

  private
    def calculate_distance
      start_point_coordinates = Geocoder.coordinates(activity_params[:start_point])
      end_point_coordinates = Geocoder.coordinates(activity_params[:end_point])
      (Geocoder::Calculations.distance_between(start_point_coordinates, end_point_coordinates, :units => :km)).round(2)
    end

    def activity_params
      params.require(:activity).permit(:start_point, :end_point)
    end
end