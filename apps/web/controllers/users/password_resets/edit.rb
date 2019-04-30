module Web
  module Controllers
    module Users
      module PasswordResets
        class Edit
          include Web::Action
          expose :user

          def call(params)
            interactor = Interactors::User::PasswordReset::Edit.new(params).call

            if interactor.successful?
              @user = interactor.user
            else
              flash[:errors] = interactor.error
              self.status = 422
              redirect_to routes.root_path
            end
          end
        end
      end
    end
  end
end
