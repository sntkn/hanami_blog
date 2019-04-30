require 'factories/user_factory'
RSpec.describe Interactors::User::EmailUpdate, type: :entity do
  let(:user) { UserFactory.new.authenticated }
  let(:attributes) { {id: user.id, user: {email: user.email, unconfirmed_email: 'test@example.com', unconfirmed_email_confirmation: 'test@example.com'}} }
  let(:error_attributes) { {id: user.id, user: {email: 'pass@word_dummy', unconfirmed_email: 'test@example.com', unconfirmed_email_confirmation: 'test@example.com'}} }

  context "good input" do
    let(:result) { Interactors::User::EmailUpdate.new(attributes).call }
    it "succeeds" do
      expect(result.successful?).to be true
    end
  end

  context "invalid input" do
    let(:result) { Interactors::User::EmailUpdate.new(error_attributes).call }
    it "fails" do
      expect(result.successful?).to be false
    end
  end
end