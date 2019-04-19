module Web
  module Controllers
    module Users
      class Authenticate
        include Web::Action
        expose :user

        def call(params)
          interactor = Interactors::User::Authenticate.new(params.get(:user)).call

          if interactor.successful?
            @user = interactor.users.first
            token_session(@user.token)
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