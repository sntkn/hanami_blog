module Web
  module Controllers
    module Users
      class Activate
        include Web::Action
        expose :user

        def call(params)
          interactor = Interactors::User::Activate.new(params).call

          if interactor.successful?
            @user = interactor.users.first
            token_session(@user.token)
            flash[:success] = 'Account has been activated!'
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
