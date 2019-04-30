require 'factories/user_factory'
RSpec.describe Interactors::User::Authenticate, type: :entity do
  let(:user) { UserFactory.new.create(email: 'test@example.com', password: '12345678@password', password_confirmation: '12345678@password') }
  let(:attributes) { {
    email: 'test@example.com',
    password: '12345678@password',
  } }
  let(:error_attributes) { {
    email: 'test@example.com',
    password: '12345678@password_error',
  } }

  context "when dont activated" do
    it "fails" do
      result = Interactors::User::Authenticate.new(attributes).call
      expect(result.successful?).to be false
    end
  end
  context "good input" do
    before { UserFactory.new.activate(user) }
    it "succeeds" do
      result = Interactors::User::Authenticate.new(attributes).call
      expect(result.successful?).to be true
    end
    it "fails" do
      result = Interactors::User::Authenticate.new(error_attributes).call
      expect(result.successful?).to be false
    end
  end
end