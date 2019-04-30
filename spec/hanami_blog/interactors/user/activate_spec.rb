require 'factories/user_factory'
RSpec.describe Interactors::User::Activate, type: :entity do
  let(:user) { UserFactory.new.create }
  let(:attributes) { {id: user.id, activation_digest: user.activation_digest} }
  let(:error_attributes) { {id: user.id, activation_digest: user.activation_digest + 'dummy'} }
  let(:activated_user) { UserFactory.new.authenticated }

  context "good input" do
    let(:result) { Interactors::User::Activate.new(attributes).call }
    it "succeeds" do
      expect(result.successful?).to be true
    end
  end

  context "invalid input" do
    let(:result) { Interactors::User::Activate.new(error_attributes).call }
    it "fails" do
      expect(result.successful?).to be false
    end
  end

  context 'already activated' do
    let!(:attributes) { {id: activated_user.id, activation_digest: activated_user.activation_digest} }
    let(:result) { Interactors::User::Activate.new(attributes).call }
    it 'fails' do
      expect(result.successful?).to be false
    end

  end

  context "good input for timeover" do
    let!(:user) { UserFactory.new.create }
    let(:result) { Interactors::User::Activate.new(attributes).call }
    before { Timecop.travel(Time.now + 60 * 60) }
    it "fails" do
      expect(result.successful?).to be false
      expect(result.error[:activation_expired_at]).not_to be nil
    end
  end
end