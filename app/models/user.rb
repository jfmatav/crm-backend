class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true

  enum :role, [:basic, :admin]

  def admin?
    role == "admin"
  end
end
