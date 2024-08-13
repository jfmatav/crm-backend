class Customer < ApplicationRecord
  validates :name, :surname, :cx_id, presence: true

  has_one_attached :photo
end
