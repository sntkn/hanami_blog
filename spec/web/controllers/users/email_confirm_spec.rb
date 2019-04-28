require 'factories/user_factory'
RSpec.describe Web::Controllers::Users::EmailConfirm, type: :action do
  let(:action) { described_class.new }
  let(:user) { 
    user = UserFactory.new.authenticated
    UserFactory.new.email_update(user)
  }
  let(:session) { { token: user.token } }
  let(:params) { {id: user.id, 'rack.session' => session, confirmation_digest: user.confirmation_digest} }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
