RSpec.describe Interactors::User::Create, type: :entity do
  let(:attributes) { {
    name: 'test',
    email: 'test@example.com',
    password: '12345678@password',
    password_confirmation: '12345678@password',
  } }
  let(:created_user) { UserFactory.new.create(email: 'test@example.com') }
  let(:activated_user) { UserFactory.new.authenticated(email: 'test@example.com', name: 'activated_name') }

  context "good input" do
    let(:result) { Interactors::User::Create.new(attributes).call }

    it "succeeds" do
      expect(result.successful?).to be true
    end

    it "creates a User with correct name and email" do
      expect(result.user.name).to eq "test"
      expect(result.user.email).to eq "test@example.com"
      expect(result.error).to eq nil
    end
  end

  context 'created again' do
    let!(:created_user) { Interactors::User::Create.new(attributes).call }
    let(:result) { Interactors::User::Create.new(attributes).call }

    it 'update succeeds' do
      expect(result.successful?).to be true
      expect(result.user.id).to eq created_user.user.id
    end
  end

  context 'created again against activated' do
    let!(:activated_user) { Interactors::User::Create.new(attributes).call }
    let(:result) { Interactors::User::Create.new(attributes).call }

    it 'not update' do
      expect(result.successful?).to be true
      expect(result.user.name).to eq activated_user.user.name
    end
  end
end