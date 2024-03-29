# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :origin, class_name: 'Report'
  belongs_to :destination, class_name: 'Report'
  validates :origin_id, presence: true
  validates :destination_id, presence: true
end
