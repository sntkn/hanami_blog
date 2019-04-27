require 'factories/user_factory'
RSpec.describe Web::Controllers::Users::EmailConfirm, type: :action do
  let(:action) { described_class.new }
  let(:user) { UserFactory.new.authenticated }
  let(:session) { { token: user.token } }
  let(:params) { {id: email_user.id, 'rack.session' => session, confirmation_digest: email_user.confirmation_digest} }
  let!(:email_user) do
    result = Interactors::User::EmailUpdate.new(id: user.id, user: {email: user.email, unconfirmed_email: 'test@example.com', unconfirmed_email_confirmation: 'test@example.com'}).call
    UserRepository.new.find(result.user.id)
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
