module Web
  module Controllers
    module Users
      class SignIn
        include Web::Action
        expose :user

        def call(params)
        end
      end
    end
  end
end
