class UserRepository < Hanami::Repository
  associations do
    has_one :user_password_forgots
  end

  def find_by_email(email: email)
    users.where(email: email).one
  end

  def find_by_activation_digest(activation_digest: activation_digest)
    users.where(activation_digest: activation_digest).one
  end

  def activate(user)
    update(user.id, activated: true, activated_at: Time.now)
  end

  def generate_token_of_user(user)
    token = SecureRandom.urlsafe_base64(100)
    update(user.id, token: token)
  end

  def find_by_token(token: token)
    users.where(token: token)
  end

  def authenticate(email: email, password: password)
    users.where(email: email, password: Digest::SHA256.hexdigest(password)).one
  end

  def find_with_password_forgot(user_id)
    aggregate(:user_password_forgots).where(id: user_id).one
  end

  def replace_password_forgot(user)
    assoc(:user_password_forgots, user).replace(
      password_digest: SecureRandom.urlsafe_base64(nil, false),
      expired_at: Time.now + 60 * 60
      )
  end

  def reset_password_forgot(user)
    assoc(:user_password_forgots, user).update(password_digest: '', expired_at: Time.now)
  end

  def update_password(user, password: password)
    update(user.id, password: Digest::SHA256.hexdigest(password))
  end

  def update_email(user)
    update(user.id,
            email: user.unconfirmed_email,
            unconfirmed_email: '',
            confirmation_expired_at: Time.now,
          )
  end

  def update_unconfirmed_email(user, unconfirmed_email: unconfirmed_email)
    update(user.id,
            unconfirmed_email: unconfirmed_email,
            confirmation_digest: SecureRandom.urlsafe_base64(nil, false),
            confirmation_expired_at: Time.now + 60 * 60,
          )
  end
end
