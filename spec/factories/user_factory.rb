class UserFactory
  def create(params = {})
    result = Interactors::User::Create.new(
      default_params.merge(params)
    ).call

    result.user
  end

  def default_params
    {
    name: 'test',
    email: 'test@example.com',
    password: '12345678@password',
    password_confirmation: '12345678@password',
    }
  end

  def activate(user)
    result = Interactors::User::Activate.new(id: user.id, activation_digest: user.activation_digest).call
    result.user
  end

  def authenticate(user, password: password)
    result = Interactors::User::Authenticate.new(email: user.email, password: password).call
    result.user
  end

  def authenticated(params = {})
    merged_params = default_params.merge(params)
    user = authenticate(activate(create(params)), password: merged_params[:password])
    UserRepository.new.find(user.id)
  end

  def password_forgot(user)
    result = Interactors::User::PasswordForgot.new(email: user.email).call
    result.user
  end

  def email_update(user)
    result = Interactors::User::EmailUpdate.new(id: user.id, user: {email: user.email, unconfirmed_email: 'test@example.com', unconfirmed_email_confirmation: 'test@example.com'}).call
    result.user
  end
end