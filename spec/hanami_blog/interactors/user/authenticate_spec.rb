require 'factories/user_factory'
RSpec.describe Interactors::User::Authenticate, type: :entity do
  let(:user) { UserFactory.new.create(email: 'test@example.com', password: '12345678@password', password_confirmation: '12345678@password') }
  let(:attributes) { Hash[
    email: 'test@example.com',
    password: '12345678@password',
  ] }
  let(:error_attributes) { Hash[
    email: 'test@example.com',
    password: '12345678@password_error',
  ] }

  context "when dont activated" do
    it "falthy" do
      result = Interactors::User::Authenticate.new(attributes).call
      expect(result.successful?).to be(false)
    end
  end
  context "good input" do
    before { UserFactory.new.activate(user.activation_digest) }
    it "succeeds" do
      result = Interactors::User::Authenticate.new(attributes).call
      expect(result.successful?).to be(true)
    end
    it "falthy" do
      result = Interactors::User::Authenticate.new(error_attributes).call
      expect(result.successful?).to be(false)
    end
  end
end