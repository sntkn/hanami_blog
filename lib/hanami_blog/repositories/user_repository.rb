class UserRepository < Hanami::Repository
  def find_by_email(email)
    users.where(email: email)
  end

  def find_by_activation_digest(digest)
    users.where(activation_digest: digest)
  end

  def activate(user_id)
    update(user_id, activated: true, activated_at: Time.now)
  end

  def generate_token_of_user(user_id)
    token = SecureRandom.urlsafe_base64(100)
    update(user_id, token: token)
  end

  def find_by_token(token: token)
    users.where(token: token)
  end

  def authenticate(email: email, password: password)
    users.where(email: email, password: password)
  end

end
