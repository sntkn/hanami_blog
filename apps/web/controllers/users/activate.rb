module Web
  module Controllers
    module Users
      class Activate
        include Web::Action
        expose :token

        def call(params)
          interactor = Interactors::User::Activate.new(params).call

          if interactor.successful?
            @user = interactor.user
            token_session(interactor.token)
            flash[:success] = 'Account has been activated!'
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
