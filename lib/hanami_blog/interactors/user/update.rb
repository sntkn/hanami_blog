require 'hanami/interactor'
module Interactors
  module User
    class Update
      include Hanami::Interactor

      class Validation
        include Hanami::Validations
        validations do
          required(:name).filled(:str?)
        end
      end

      expose :user, :params

      def initialize(params, repository: UserRepository.new)
        @params = params[:user]
        @repository = repository
        @user = repository.find(params[:id])
      end

      def call
        @repository.update(@user.id, name: @params[:name])
      end

      def valid?
        error(id: ["is invalid"]) if @user.nil?
        validation = Validation.new(@params).validate
        error(validation.messages) if validation.failure?

        validation.success?
      end
    end
  end
end