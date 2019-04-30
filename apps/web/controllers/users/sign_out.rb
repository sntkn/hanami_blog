module Web
  module Controllers
    module Users
      class SignOut
        attr_accessor :required_authentication
        include Web::Action

        def call(params)
          sign_out
          flash[:success] = 'Sign out succeded'
          redirect_to routes.root_path
        end
      end

      def authentication
        true
      end
    end
  end
end
