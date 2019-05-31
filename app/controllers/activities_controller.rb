# frozen_string_literal: true

class ActivitiesController < ApplicationController
  before_action :find_activity, only: %i[show destroy]
  before_action :authenticate_user!

  def new
    @activity = Activity.new
  end

  def create
    @activity = current_user.activities.build(activity_params)
    @activity.distance = DistanceCalculator.new(activity_params).call
    if @activity.save
      flash[:success] = 'You have just added a new activity!'
      redirect_to @activity
    else
      render 'new'
    end
  end

  def show
    @weekly_distance = current_user.activities.weekly_distance
  end

  def index
    @monthly_statistics = current_user.activities.monthly_statistics
  end

  def destroy
    @activity.destroy
    flash[:success] = 'Activity deleted'
    redirect_to root_path
  end

  private

  def activity_params
    params.require(:activity).permit(:start_point, :end_point)
  end

  def find_activity
    @activity = Activity.find(params[:id])
  end
end
