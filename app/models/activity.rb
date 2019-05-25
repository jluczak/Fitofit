# frozen_string_literal: true

class Activity < ApplicationRecord
  validates :start_point, :end_point, presence: true, address: true,
                                      format: { with: /.+\,.+\,.+/i, message: 'please enter adress in correct format' }
  validates :distance, presence: true, numericality: { greater_than: 0 }
  belongs_to :user
end
