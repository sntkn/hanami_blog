require 'factories/user_factory'
RSpec.describe Interactors::User::Update, type: :entity do
  let(:user) { UserFactory.new.authenticated }
  let(:attributes) { {id: user.id, user: {name: 'changed name'} } }
  let(:error_attributes) { {id: user.id, user: {name: ''} } }

  context "good input" do
    it "succeeds" do
      result = Interactors::User::Update.new(attributes).call
      expect(result.successful?).to be true
    end
  end

  context "invalid input" do
    it "fails" do
      result = Interactors::User::Update.new(error_attributes).call
      expect(result.successful?).to be false
    end
  end
end
