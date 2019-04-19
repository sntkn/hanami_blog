require 'factories/user_factory'
RSpec.describe Interactors::User::Activate, type: :entity do
  let(:user) { UserFactory.new.create }
  let(:attributes) { Hash[activation_digest: user.activation_digest] }
  let(:error_attributes) { Hash[activation_digest: user.activation_digest + 'dummy'] }

  context "good input" do
    it "succeeds" do
      result = Interactors::User::Activate.new(attributes).call
      expect(result.successful?).to be(true)
    end
  end
  context "invalid input" do
    it "errores" do
      result = Interactors::User::Activate.new(error_attributes).call
      expect(result.successful?).to be(false)
    end
  end
end