require 'factories/user_factory'
RSpec.describe Interactors::User::PasswordForgot, type: :entity do
  let(:user) { UserFactory.new.create(email: 'test@example.com') }
  let(:attributes) { {email: user.email} }
  let(:error_attributes) { {email: user.email + 'dummy'} }


  context "good input" do
    let(:result) { Interactors::User::PasswordForgot.new(attributes).call }

    it "succeeds" do
      expect(result.successful?).to be true
      expect(result.user.email).to eq 'test@example.com'
    end
  end

  context "bad input" do
    let(:result) { Interactors::User::PasswordForgot.new(error_attributes).call }

    it "succeeds" do
      expect(result.successful?).to be true
      expect(result.user).to be nil
    end
  end
end