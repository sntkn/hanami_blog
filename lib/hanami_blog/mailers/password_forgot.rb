module Mailers
  class PasswordForgot
    include Hanami::Mailer

    from    'noreply@bookshelf.org'
    to      :recipient
    subject :subject
    template 'password_forget'

    private

    def recipient
      user.email
    end

    def reset_password_url
      "#{Web.routes.edit_user_password_reset_url(user.id, user.user_password_forgots.id)}?password_digest=#{user.user_password_forgots.password_digest}"
    end

    def subject
      "forget #{user.name}"
    end
  end
end
