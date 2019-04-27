require 'factories/user_factory'
RSpec.describe Interactors::User::PasswordReset::Update, type: :entity do
  let(:user) { UserFactory.new.create }
  let!(:password_forgot) { UserFactory.new.password_forgot(user) }
  let(:attributes) { {
    user_id: password_forgot.id,
    user: { password: "12345678@password", password_confirmation: "12345678@password" }
  } }
  let(:user_id_error_attributes) { {
    user_id: password_forgot.id + 1,
    user: { password: "12345678@password", password_confirmation: "12345678@password" }
  } }

  context "good input" do
    let(:result) { Interactors::User::PasswordReset::Update.new(attributes).call }
    it "succeeds" do
      expect(result.successful?).to be true
    end
  end

  context "good input for timeover" do
    let(:result) { Interactors::User::PasswordReset::Update.new(attributes).call }
    it "failed" do
      Timecop.travel(Time.now + 60 * 60)
      expect(result.successful?).to be false
      expect(result.error[:expired_at]).not_to be nil
    end
  end

  context "bad input for user_id" do
    let(:result) { Interactors::User::PasswordReset::Update.new(user_id_error_attributes).call }
    it "failed" do
      expect(result.successful?).to be false
      expect(result.error[:user_id]).not_to be nil
    end
  end
end