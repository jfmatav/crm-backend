class User < ApplicationRecord
  enum role: { basic: 0, admin: 1 }
end
