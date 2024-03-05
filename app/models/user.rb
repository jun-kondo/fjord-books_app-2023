# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :zip_code, numericality: { only_integer: true }, allow_blank: true
  validates :address, length: { maximum: 100 }, allow_blank: true
  validates :self_introduction, length: { maximum: 400 }, allow_blank: true
end
