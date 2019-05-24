class Activity < ApplicationRecord
  validates :start_point, :end_point, presence:true
  belongs_to :user
end
