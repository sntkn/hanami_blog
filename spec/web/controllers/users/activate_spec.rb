require 'factories/user_factory'
RSpec.describe Web::Controllers::Users::Activate, type: :action do
  let(:action) { described_class.new }
  let(:user) { UserFactory.new.create }
  let(:params) { Hash[activation_digest: user.activation_digest] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
