require 'factories/user_factory'
RSpec.describe Web::Controllers::Users::SignOut, type: :action do
  let(:action) { described_class.new }
  let(:user) { UserFactory.new.create(password: '12345678@password') }
  let(:activated_user) { UserFactory.new.activate(user.activation_digest) }
  let(:authenticate) { UserFactory.new.authenticate(activated_user.email, '12345678@password') }
  let(:params) { { 'rack.session' => session } }
  let(:session) { { token: authenticate.token } }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
