RSpec.describe Mailers::Welcome, type: :mailer do
  it 'delivers email' do
    user = UserRepository.new.create(
      name: 'test',
      email: 'test@example.com',
      password: Digest::SHA256.hexdigest('12345678@password'),
      activation_digest: SecureRandom.urlsafe_base64(nil, false),
      token: "",
    )
    mail = Mailers::Welcome.deliver(user: user)
  end
end
