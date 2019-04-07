module Web
  module Controllers
    module Users
      class Create
        include Web::Action
        expose :user, :error

        def call(params)
          interactor = AddUser.new(params.get(:user)).call

          if interactor.successful?
            @user = interactor.user
            redirect_to routes.root_path
          else
            @error = interactor.error
            self.status = 422
          end
        end
      end
    end
  end
end
