require 'hanami/interactor'
module Interactors
  module User
    class PasswordUpdate
      include Hanami::Interactor

      class Validation
        include Hanami::Validations
        validations do
          required(:password).filled(:str?, size?: 8..100)
          required(:new_password).filled(:str?, size?: 8..100).confirmation
        end
      end

      expose :user, :params

      def initialize(params, repository: UserRepository.new)
        @params = params[:user]
        @repository = repository
        @user = repository.find(params[:id])
      end

      def call
        @repository.update_password(@user, password: @params[:new_password])
      end

      def valid?
        validation = Validation.new(@params).validate
        error(validation.messages) if validation.failure?
        error!(id: ["is invalid"]) if @user.nil?
        error!(password: ["is invalid"]) unless @user.valid_password?(@params[:password])

        validation.success?
      end
    end
  end
end