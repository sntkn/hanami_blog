require 'factories/user_factory'
RSpec.describe Web::Controllers::Users::Update, type: :action do
  let(:action) { described_class.new }
  let(:user) { UserFactory.new.authenticated }
  let(:session) { { token: user.token } }
  let(:params) { {id: user.id, 'rack.session' => session, user: {name: 'test'} } }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
