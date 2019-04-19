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

  def activate(activation_digest)
    result = Interactors::User::Activate.new(activation_digest: activation_digest).call
    result.users.first
  end

  def authenticate(email, password)
    result = Interactors::User::Authenticate.new(email: email, password: password).call
    result.users.first
  end
end