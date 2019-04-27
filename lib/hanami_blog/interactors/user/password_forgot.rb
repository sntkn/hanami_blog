require 'hanami/interactor'
module Interactors
  module User
    class PasswordForgot
      include Hanami::Interactor

      class Validation
        include Hanami::Validations
        validations do
          required(:email).filled(:str?)
        end
      end

      expose :user, :params

      def initialize(params, repository: UserRepository.new, mailer: Mailers::PasswordForgot)
        @params = params
        @repository = repository
        @mailer = mailer
      end

      def call
        @user = @repository.find_by_email(email: @params[:email])

        # メールが存在していることがわからないように何もしないで返却
        return if @user.nil?

        @repository.replace_password_forgot(@user)

        @user = @repository.find_with_password_forgot(@user.id)
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