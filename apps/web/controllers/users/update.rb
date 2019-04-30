module Web
  module Controllers
    module Users
      class Update
        attr_accessor :required_authentication, :required_user_authentication
        include Web::Action
        expose :user

        def call(params)
          interactor = Interactors::User::Update.new(params).call
          @user = interactor.user

          if interactor.successful?
            flash[:success] = "Account update succeeded!"
            redirect_to routes.user_path(@user.id)
          else
            flash[:errors] = interactor.error
            self.status = 422
          end
        end
      end
    end
  end
end
