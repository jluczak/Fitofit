# frozen_string_literal: true

class AddressValidator < ActiveModel::Validator
  def validate(record)
    if invalid_address?(record.start_point)
      record.errors.add(:start_point, 'invalid address')
    end
    if invalid_address?(record.end_point)
      record.errors.add(:end_point, 'invalid address')
    end
    if same_address?(record.start_point, record.end_point)
      record.errors.add(:start_point, 'same start point and end point')
      record.errors.add(:end_point, 'same start point and end point')
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
