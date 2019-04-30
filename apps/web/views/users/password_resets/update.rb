module Web
  module Views
    module Users
      module PasswordResets
        class Update
          include Web::View
          template "users/password_resets/edit"
        end
      end
    end
  end
end
