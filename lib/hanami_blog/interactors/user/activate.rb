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

      expose :user, :params

      def initialize(params, repository: UserRepository.new)
        @params = params
        @repository = repository
        @user = @repository.find(params[:id]) #(activation_digest: @params[:activation_digest])
      end

      def call
        @repository.activate(@user)
        @repository.generate_token_of_user(@user)
      end

      def valid?
        validation = Validation.new(@params).validate
        error(validation.messages) if validation.failure?
        error!(id: ["is invalid"]) if @user.nil?
        error!(activation_digest: ["is invalid"]) if @user.activation_digest != @params[:activation_digest]

        validation.success?
      end
    end
  end
end