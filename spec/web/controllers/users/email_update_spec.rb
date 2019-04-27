require 'factories/user_factory'
RSpec.describe Web::Controllers::Users::EmailUpdate, type: :action do
  let(:action) { described_class.new }
  let(:user) { UserFactory.new.authenticated }
  let(:session) { { token: user.token } }
  let(:params) { {id: user.id, 'rack.session' => session, user: {
    email: user.email,
    unconfirmed_email: 'test@example.com',
    unconfirmed_email_confirmation: 'test@example.com'
    } } }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
