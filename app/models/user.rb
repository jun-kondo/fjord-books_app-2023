# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [100, 100]
  end
  validates :image, content_type: %w[image/jpeg image/png image/gif],
                    size: { less_than: 5.megabytes }
end
