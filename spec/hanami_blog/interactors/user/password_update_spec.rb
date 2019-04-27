require 'factories/user_factory'
RSpec.describe Interactors::User::PasswordUpdate, type: :entity do
  let(:user) { UserFactory.new.authenticated(password: 'pass@word', password_confirmation: 'pass@word') }
  let(:attributes) { {id: user.id, user: {password: 'pass@word', new_password: 'new.pass@word', new_password_confirmation: 'new.pass@word'}} }
  let(:error_attributes) { {id: user.id, user: {password: 'pass@word_dummy', new_password: 'new.pass@word', new_password_confirmation: 'new.pass@word'}} }

  context "good input" do
    it "succeeds" do
      result = Interactors::User::PasswordUpdate.new(attributes).call
      expect(result.successful?).to be(true)
    end
  end

  context "invalid input" do
    it "fails" do
      result = Interactors::User::PasswordUpdate.new(error_attributes).call
      expect(result.successful?).to be(false)
    end
  end
end