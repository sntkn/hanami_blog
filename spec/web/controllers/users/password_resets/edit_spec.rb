require 'factories/user_factory'
RSpec.describe Web::Controllers::Users::PasswordResets::Edit, type: :action do
  let(:action) { described_class.new }
  let(:user) { UserFactory.new.create }
  let(:activete) { UserFactory.new.activate(user) }
  let!(:password_forgot) { UserFactory.new.password_forgot(user) }
  let(:params) { Hash[
    user_id: password_forgot.id,
    password_digest: password_forgot.user_password_forgots.password_digest
  ] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
