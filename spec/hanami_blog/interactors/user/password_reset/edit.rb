require 'factories/user_factory'
RSpec.describe Interactors::User::PasswordReset::Edit, type: :entity do
  let(:user) { UserFactory.new.create }
  let!(:password_forgot) { UserFactory.new.password_forgot(user) }
  let(:attributes) { {
    user_id: password_forgot.id,
    password_digest: password_forgot.user_password_forgots.password_digest
   } }
  let(:user_id_error_attributes) { {
    user_id: password_forgot.id + 1,
    password_digest: password_forgot.user_password_forgots.password_digest
   } }
  let(:password_digest_error_attributes) { {
    user_id: password_forgot.id,
    password_digest: password_forgot.user_password_forgots.password_digest + 'dummy'
  } }

  context "good input" do
    let(:result) { Interactors::User::PasswordReset::Edit.new(attributes).call }
    it "succeeds" do
      expect(result.successful?).to be true
    end
  end

  context "good input for timeover" do
    let(:result) { Interactors::User::PasswordReset::Edit.new(attributes).call }
    it "failed" do
      Timecop.travel(Time.now + 60 * 60)
      expect(result.successful?).to be false
      expect(result.error[:expired_at]).not_to be nil
    end
  end

  context "bad input for user_id" do
    let(:result) { Interactors::User::PasswordReset::Edit.new(user_id_error_attributes).call }
    it "failed" do
      expect(result.successful?).to be false
      expect(result.error[:user_id]).not_to be nil
    end
  end

  context "bad input for password_digest" do
    let(:result) { Interactors::User::PasswordReset::Edit.new(password_digest_error_attributes).call }
    it "failed" do
      expect(result.successful?).to be false
      expect(result.error[:password_digest]).not_to be nil
    end
  end
end