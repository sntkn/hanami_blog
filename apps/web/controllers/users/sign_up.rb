module Web
  module Controllers
    module Users
      class SignUp
        include Web::Action
        expose :user, :error

        def call(params)
        end
      end
    end
  end
end
