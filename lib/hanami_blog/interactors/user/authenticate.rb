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

      expose :user, :token, :params

      def initialize(params, repository: UserRepository.new)
        @params = params
        @repository = repository
        @user = @repository.authenticate(
          email: @params[:email],
          password: @params[:password],
        )
      end

      def call
        @token = @repository.generate_token_of_user(@user).token
      end

      def valid?
        validation = Validation.new(@params).validate
        error(validation.messages) if validation.failure?
        error!(sign_in: ["email or password are invalid"]) if @user.nil?
        error!(activated: ['is not activated']) unless @user.activated

        validation.success?
      end
    end
  end
end