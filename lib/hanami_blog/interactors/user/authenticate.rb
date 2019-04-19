require 'hanami/interactor'
module Interactors
  module User
    class Authenticate
      include Hanami::Interactor

      class Validation
        include Hanami::Validations

        validations do
          required(:email).filled(:str?)
          required(:password).filled(:str?)
        end
      end

      expose :users, :params

      def initialize(params, repository: UserRepository.new)
        @params = params
        @repository = repository
      end

      def call
        @users = @repository.authenticate(
          email: @params[:email],
          password: Digest::SHA256.hexdigest(@params[:password]),
        )
        return error(sign_in: ["email or password are invalid"]) if @users.count.zero?
        return error(sign_in: ['dont activated']) unless @users.first.activated
      end

      def valid?
        validation = Validation.new(@params).validate
        error(validation.messages) if validation.failure?

        validation.success?
      end
    end
  end
end