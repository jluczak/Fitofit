class Activity < ApplicationRecord
  validates :start_point, :end_point, presence: true, format: { with: /.+\,.+\,.+/i, message: "please enter adress in correct format"}
  validates :distance, presence: true , numericality: { greater_than: 0 }
  validates_with AddressValidator
  belongs_to :user
end
