module Web
  module Controllers
    module Users
      class EmailConfirm
        attr_accessor :required_authentication, :required_user_authentication
        include Web::Action
        expose :user

        def call(params)
          interactor = Interactors::User::EmailConfirm.new(params).call

          if interactor.successful?
            @user = interactor.user
            flash[:success] = 'New Email Updated!'
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
