RSpec.describe AddBook, type: :entity do
  let(:attributes) { Hash[
    name: 'test',
    email: 'test@example.com',
    password: '12345678@password',
    password_confirmation: '12345678@password',
] }

  context "good input" do
    let(:result) { AddUser.new(attributes).call }

    it "succeeds" do
      expect(result.successful?).to be(true)
    end

    it "creates a User with correct name and email" do
      expect(result.user.name).to eq("test")
      expect(result.user.email).to eq("test@example.com")
      expect(result.error).to eq(nil)
    end
  end

  context "persistence" do
    let(:repository) { instance_double("BookRepository") }

    it "persists the Book" do
      expect(repository).to receive(:create)
      AddBook.new(repository: repository).call(attributes)
    end
  end
end