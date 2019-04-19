RSpec.describe Interactors::User::Create, type: :entity do
  let(:attributes) { Hash[
    name: 'test',
    email: 'test@example.com',
    password: '12345678@password',
    password_confirmation: '12345678@password',
] }

  context "good input" do
    let(:result) { Interactors::User::Create.new(attributes).call }

    it "succeeds" do
      expect(result.successful?).to be(true)
    end

    it "creates a User with correct name and email" do
      expect(result.user.name).to eq("test")
      expect(result.user.email).to eq("test@example.com")
      expect(result.error).to eq(nil)
    end
  end
end