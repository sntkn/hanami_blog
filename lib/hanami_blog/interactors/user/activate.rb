require 'hanami/interactor'
module Interactors
  module User
    class Activate
      include Hanami::Interactor

      class Validation
        include Hanami::Validations
        validations do
          required(:activation_digest).filled(:str?)
        end
      end

      expose :user, :token

      def initialize(params, repository: UserRepository.new)
        @params = params
        @repository = repository
        @user = @repository.find(params[:id])
      end

      def call
        @repository.activate(@user)
        @token = @repository.generate_token_of_user(@user).token
      end

      def valid?
        validation = Validation.new(@params).validate
        error(validation.messages) if validation.failure?
        error!(id: ["is invalid"]) if @user.nil?
        error!(id: ['is already activated']) if @user.activated
        error!(activation_digest: ["is invalid"]) unless @user.activation_digest == @params[:activation_digest]
        error!(activation_expired_at: ["is expired"]) if @user.activation_expired_at < Time.now

        validation.success?
      end
    end
  end
end