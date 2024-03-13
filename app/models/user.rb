# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [100, 100]
  end
end
