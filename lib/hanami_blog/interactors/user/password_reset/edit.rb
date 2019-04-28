require 'hanami/interactor'
module Interactors
  module User
    module PasswordReset
      class Edit
        include Hanami::Interactor

        class Validation
          include Hanami::Validations

          validations do
            required(:password_digest).filled(:str?)
          end
        end

        expose :user, :password_forgot, :params

        def initialize(params, repository: UserRepository.new)
          @params = params
          @repository = repository
          @user = @repository.find_with_password_forgot(@params[:user_id])
        end

        def call
        end

        def valid?
          validation = Validation.new(@params).validate
          error(validation.messages) if validation.failure?
          error!(user_id: ["is invalid"]) if @user.nil?
          error!(password_digest: ["is invalid"]) if @user.user_password_forgots.password_digest != @params[:password_digest]
          error!(expired_at: ["is expired"]) if @user.user_password_forgots.expired_at < Time.now
          validation.success?
        end
      end
    end
  end
end