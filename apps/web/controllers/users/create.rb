module Web
  module Controllers
    module Users
      class Create
        include Web::Action
        expose :user

        def call(params)
          interactor = Interactors::User::Create.new(params.get(:user)).call

          if interactor.successful?
            @user = interactor.user
            flash[:success] = "Account Created, and send your email address.\nPlease confirm email and click activation url."
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
