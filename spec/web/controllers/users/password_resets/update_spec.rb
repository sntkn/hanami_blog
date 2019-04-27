require 'factories/user_factory'
RSpec.describe Web::Controllers::Users::PasswordResets::Update, type: :action do
  let(:action) { described_class.new }
  let(:user) { UserFactory.new.create }
  let(:activete) { UserFactory.new.activate(user) }
  let!(:password_forgot) { UserFactory.new.password_forgot(user) }
  let(:params) { Hash[
    user_id: password_forgot.id,
    user: { password: "12345678@password", password_confirmation: "12345678@password" }
  ] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
