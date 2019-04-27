require 'hanami/interactor'
module Interactors
  module User
    class EmailUpdate
      include Hanami::Interactor

      class Validation
        include Hanami::Validations
        predicate :email?, message: 'must be an email format' do |current|
          current.match(/\A.+@.+\..+\z/)
        end
        validations do
          required(:email).filled(:str?)
          required(:unconfirmed_email).filled(:str?, :email?).confirmation
        end
      end

      expose :user, :params

      def initialize(params, repository: UserRepository.new, mailer: Mailers::EmailConfirmation)
        @params = params[:user]
        @repository = repository
        @user = repository.find(params[:id])
        @mailer = mailer
      end

      def call
        @repository.update_unconfirmed_email(@user, unconfirmed_email: @params[:unconfirmed_email])
        @mailer.deliver(user: @repository.find(@user.id))
      end

      def valid?
        error!(id: ["is invalid"]) if @user.nil?
        validation = Validation.new(@params).validate
        error!(validation.messages) if validation.failure?
        error!(email: ["is invalid"]) unless @user.email == @params[:email]

        validation.success?
      end
    end
  end
end