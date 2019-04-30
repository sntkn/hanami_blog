require 'hanami/interactor'
module Interactors
  module User
    class EmailConfirm
      include Hanami::Interactor

      class Validation
        include Hanami::Validations
        validations do
          required(:confirmation_digest).filled(:str?)
        end
      end

      expose :user, :params

      def initialize(params, repository: UserRepository.new)
        @params = params
        @repository = repository
        @user = repository.find(params[:id])
      end

      def call
        @repository.update_email(@user)
      end

      def valid?
        validation = Validation.new(@params).validate
        error(validation.messages) if validation.failure?
        error!(id: ["is invalid"]) if @user.nil?
        error!(confirmation_digest: ["is invalid"]) unless @user.confirmation_digest == @params[:confirmation_digest]
        error!(confirmation_expired_at: ["is expired"]) if @user.confirmation_expired_at < Time.now

        validation.success?
      end
    end
  end
end