module Web
  module Controllers
    module Users
      class EmailEdit
        attr_accessor :required_authentication, :required_user_authentication
        include Web::Action
        expose :user

        def call(params)
          @user = current_user
        end
      end
    end
  end
end
