require 'factories/user_factory'
RSpec.describe Web::Controllers::PasswordForgots::Create, type: :action do
  let(:action) { described_class.new }
  let(:user) { UserFactory.new.create(email: 'test@example.com') }
  let(:params) { {email: user.email} }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
