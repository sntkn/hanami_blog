require 'factories/user_factory'
RSpec.describe Web::Controllers::Users::PasswordUpdate, type: :action do
  let(:action) { described_class.new }
  let(:user) { UserFactory.new.authenticated(password: 'test@example.com', password_confirmation: 'test@example.com') }
  let(:session) { { token: user.token } }
  let(:params) { {id: user.id, 'rack.session' => session, user: {
    password: 'test@example.com',
    new_password: 'new.pass@word',
    new_password_confirmation: 'new.pass@word'}
    } }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
