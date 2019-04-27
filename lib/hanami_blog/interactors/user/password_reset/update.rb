require 'hanami/interactor'
module Interactors
  module User
    module PasswordReset
      class Update
        include Hanami::Interactor

        class Validation
          include Hanami::Validations

          validations do
            required(:password).filled(:str?, size?: 8..100).confirmation
          end
        end

        expose :user, :params

        def initialize(params, repository: UserRepository.new)
          @params = params[:user]
          @repository = repository
          @user = @repository.find_with_password_forgot(params[:user_id])
        end

        def call
          @repository.update_password(@user, password: @params[:password])
          @repository.reset_password_forgot(@user)
        end

        def valid?
          validation = Validation.new(@params).validate
          error(validation.messages) if validation.failure?
          error!(user_id: ["user is invalid"]) if @user.nil?
          error!(expired_at: ["password reset is timeout"]) if @user.user_password_forgots.expired_at < Time.now
          validation.success?
        end
      end
    end
  end
end