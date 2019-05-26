# frozen_string_literal: true

class AddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, 'is invalid') if invalid_address?(value)
    if same_address?(record.start_point, record.end_point)
      message = 'same start point and end point'
      record.errors.add(attribute, message)
    end
  end

  private

  def invalid_address?(address)
    Geocoder.coordinates(address).nil?
  end

  def same_address?(start_point, end_point)
    Geocoder.coordinates(start_point) == Geocoder.coordinates(end_point)
  end
end
