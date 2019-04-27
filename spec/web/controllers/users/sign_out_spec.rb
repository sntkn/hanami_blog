require 'factories/user_factory'
RSpec.describe Web::Controllers::Users::SignOut, type: :action do
  let(:action) { described_class.new }
  let(:user) { UserFactory.new.authenticated }
  let(:params) { { id: user.id, 'rack.session' => session } }
  let(:session) { { token: user.token } }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
