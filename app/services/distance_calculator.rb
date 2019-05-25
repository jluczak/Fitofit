# frozen_string_literal: true

class DistanceCalculator
  def initialize(params)
    @start_point = params[:start_point]
    @end_point = params[:end_point]
  end

  def call
    first_coordinates = Geocoder.coordinates(@start_point)
    second_coordinates = Geocoder.coordinates(@end_point)
    Geocoder::Calculations.distance_between(first_coordinates, second_coordinates, units: :km).round(2)
  end
end
