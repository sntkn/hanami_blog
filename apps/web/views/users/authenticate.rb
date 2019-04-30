module Web
  module Views
    module Users
      class Authenticate
        include Web::View
        template "users/sign_in"
      end
    end
  end
end
