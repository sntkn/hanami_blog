require 'factories/user_factory'
RSpec.describe Interactors::User::EmailConfirm, type: :entity do
  let(:user) { UserFactory.new.authenticated }
  let(:attributes) { {id: email_user.id, confirmation_digest: email_user.confirmation_digest} }
  let(:error_attributes) { {id: email_user.id, confirmation_digest: email_user.confirmation_digest + 'dummy'} }
  let!(:email_user) do
    result = Interactors::User::EmailUpdate.new(id: user.id, user: {email: user.email, unconfirmed_email: 'test@example.com', unconfirmed_email_confirmation: 'test@example.com'}).call
    UserRepository.new.find(result.user.id)
  end

  context "good input" do
    it "succeeds" do
      result = Interactors::User::EmailConfirm.new(attributes).call
      expect(result.successful?).to be(true)
    end
  end

  context "invalid input" do
    it "fails" do
      result = Interactors::User::EmailConfirm.new(error_attributes).call
      expect(result.successful?).to be(false)
    end
  end

  context "good input for timeover" do
    let(:result) { Interactors::User::EmailConfirm.new(attributes).call }
    it "failed" do
      Timecop.travel(Time.now + 60 * 60)
      expect(result.successful?).to be false
      expect(result.error[:confirmation_expired_at]).not_to be nil
    end
  end
end