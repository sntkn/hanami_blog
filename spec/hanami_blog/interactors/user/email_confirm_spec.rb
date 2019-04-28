require 'factories/user_factory'
RSpec.describe Interactors::User::EmailConfirm, type: :entity do
  let!(:user) { 
    user = UserFactory.new.authenticated
    UserFactory.new.email_update(user)
  }
  let(:attributes) { {id: user.id, confirmation_digest: user.confirmation_digest} }
  let(:error_attributes) { {id: user.id, confirmation_digest: user.confirmation_digest + 'dummy'} }

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