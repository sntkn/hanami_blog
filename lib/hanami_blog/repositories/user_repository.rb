class UserRepository < Hanami::Repository
  def find_by_email(email)
    users.where(email: email).first
  end

  def generate_token_of_user(user_id)
    token = SecureRandom.urlsafe_base64(24).tr('lIO0', 'sxyz')
    update(user_id, token: token)
  end
end
