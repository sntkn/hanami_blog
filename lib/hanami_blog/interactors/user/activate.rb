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

      expose :users, :params

      def initialize(params, repository: UserRepository.new)
        @params = params
        @repository = repository
      end

      def call
        @users = @repository.find_by_activation_digest(@params[:activation_digest])
        return error(activation_digest: ["activation digest is invalid"]) if @users.count.zero?
        @repository.activate(@users.first.id)
        @repository.generate_token_of_user(@users.first.id)
      end

      def valid?
        validation = Validation.new(@params).validate
        error(validation.messages) if validation.failure?

        validation.success?
      end
    end
  end
end