# frozen_string_literal: true

class ActivitiesController < ApplicationController
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
    @activity = Activity.find_by(id: params[:id])
    @weekly_distance = calculate_weekly_distance
  end

  private

  def activity_params
    params.require(:activity).permit(:start_point, :end_point)
  end

  def calculate_weekly_distance
    current_user
      .activities.where('created_at > ?', 7.days.ago)
      .sum(:distance)
  end
end
