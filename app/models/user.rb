class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true

  enum role: { basic: 0, admin: 1 }

  def admin?
    role == "admin"
  end
end
