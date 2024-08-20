def get_authentication(user)
  JWT.encode({ user_id: user.id }, ENV.fetch('PASSWORD_KEY', nil))
end
