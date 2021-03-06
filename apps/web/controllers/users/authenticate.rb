module Web
  module Controllers
    module Users
      class Authenticate
        include Web::Action
        expose :user

        def call(params)
          interactor = Interactors::User::Authenticate.new(params.get(:user)).call

          if interactor.successful?
            @user = interactor.user
            token_session(interactor.token)
            flash[:success] = 'Logged in!'
            redirect_to routes.root_path
          else
            flash[:errors] = interactor.error
            self.status = 422
          end
        end
      end
    end
  end
end
