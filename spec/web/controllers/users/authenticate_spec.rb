require 'factories/user_factory'
RSpec.describe Web::Controllers::Users::Authenticate, type: :action do
  let(:action) { described_class.new }
  let(:user) { UserFactory.new.create(password: '12345678@password') }
  let(:activated_user) { UserFactory.new.activate(user.activation_digest) }
  let(:params) { Hash[user: {
    email: activated_user.email,
    password: '12345678@password',
}] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
