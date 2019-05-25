class AddressValidator < ActiveModel::Validator
  def validate(record)
    if invalid_address?(record.start_point)
      record.errors.add(:start_point, :invalid, message: 'invalid address')
    end
    if invalid_address?(record.end_point)
      record.errors.add(:end_point, :invalid, message: 'invalid address')
    end
    if record.distance <= 0
      record.errors.add(:start_point, :invalid, message: 'same start point and end point')
      record.errors.add(:end_point, :invalid, message: 'same start point and end point')
    end
  end

  private
    def invalid_address?(address)
      Geocoder.coordinates(address).nil?
    end
end
