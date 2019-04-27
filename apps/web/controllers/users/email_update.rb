module Web
  module Controllers
    module Users
      class EmailUpdate
        attr_accessor :required_authentication, :required_user_authentication
        include Web::Action
        expose :user

        def call(params)
          interactor = Interactors::User::EmailUpdate.new(params).call
          @user = interactor.user

          if interactor.successful?
            flash[:success] = "Email had sent to your new address.\nPlease confirm email and click email confirmation url."
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
