require 'hanami/interactor'
module Interactors
  module User
    class Create
      include Hanami::Interactor

      class Validation
        include Hanami::Validations

        predicate :email?, message: 'must be an email format' do |current|
          current.match(/\A.+@.+\..+\z/)
        end

        validations do
          required(:email).filled(:str?, :email?)
          required(:name).filled(:str?)
          required(:password).filled(:str?, size?: 8..100).confirmation
        end
      end

      expose :user, :params

      def initialize(params, repository: UserRepository.new, mailer: Mailers::Welcome)
        @params = params
        @repository = repository
        @mailer = mailer
      end

      def call
        @user = @repository.create(
          name: @params[:name],
          email: @params[:email],
          password: Digest::SHA256.hexdigest(@params[:password]),
          activation_digest: SecureRandom.urlsafe_base64(nil, false),
          token: "",
        )
        @mailer.deliver(user: @user)
      end

      def valid?
        validation = Validation.new(@params).validate
        error(validation.messages) if validation.failure?

        validation.success?
      end
    end
  end
end