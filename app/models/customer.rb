class Customer < ApplicationRecord
  validates :name, :surname, :cx_id, presence: true
end
