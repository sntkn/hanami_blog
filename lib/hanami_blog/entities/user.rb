class User < Hanami::Entity
  EMAIL_FORMAT = /\@/

  attributes do
    attribute :id, Types::Strict::Int
    attribute :name, Types::Strict::String
    attribute :email, Types::Strict::String.constrained(format: EMAIL_FORMAT)
    attribute :token, Types::String
    attribute :password, Types::Strict::String
    attribute :activation_digest, Types::Strict::String
    attribute :activation_expired_at, Types::DateTime
    attribute :activated, Types::Strict::Bool
    attribute :activated_at, Types::DateTime
    attribute :unconfirmed_email, Types::String
    attribute :confirmation_digest, Types::String
    attribute :confirmation_expired_at, Types::DateTime
    attribute :created_at, Types::DateTime
    attribute :updated_at, Types::DateTime
  end

  def valid_password?(password)
    self.password == Digest::SHA256.hexdigest(password)
  end
end
