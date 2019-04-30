module Web
  module Controllers
    module PasswordForgots
      class Create
        include Web::Action
        expose :user

        def call(params)
          interactor = Interactors::User::PasswordForgot.new(params[:user]).call

          if interactor.successful?
            @user = interactor.user
            flash[:success] = 'Password reset email has sent'
          else
            flash[:errors] = interactor.error
            self.status = 422
          end
          redirect_to routes.root_path
        end
      end
    end
  end
end
