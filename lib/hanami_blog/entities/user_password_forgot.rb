class UserPasswordForgot < Hanami::Entity
  attributes :strict do
    attribute :id, Types::Strict::Int
    attribute :user_id, Types::Int
    attribute :password_digest, Types::Strict::String
    attribute :expired_at, Types::DateTime
    attribute :created_at, Types::DateTime
    attribute :updated_at, Types::DateTime
  end
end
