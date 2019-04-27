require 'factories/user_factory'
RSpec.describe Interactors::User::EmailUpdate, type: :entity do
  let(:user) { UserFactory.new.authenticated }
  let(:attributes) { {id: user.id, user: {email: user.email, unconfirmed_email: 'test@example.com', unconfirmed_email_confirmation: 'test@example.com'}} }
  let(:error_attributes) { {id: user.id, user: {email: 'pass@word_dummy', unconfirmed_email: 'test@example.com', unconfirmed_email_confirmation: 'test@example.com'}} }

  context "good input" do
    it "succeeds" do
      result = Interactors::User::EmailUpdate.new(attributes).call
      expect(result.successful?).to be(true)
    end
  end

  context "invalid input" do
    it "fails" do
      result = Interactors::User::EmailUpdate.new(error_attributes).call
      expect(result.successful?).to be(false)
    end
  end
end