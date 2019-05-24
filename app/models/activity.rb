class Activity < ApplicationRecord
  validates :start_point, :end_point, presence: true
  validates :distance, presence: true , numericality: { only_float: true }
  belongs_to :user
end
