module Mailers
  class EmailConfirmation
    include Hanami::Mailer

    from    'noreply@bookshelf.org'
    to      :recipient
    subject :subject
    template 'email_confirmation'

    private

    def recipient
      user.email
    end

    def email_confirmation_url
      "#{Web.routes.email_confirm_user_url(user.id)}?confirmation_digest=#{user.confirmation_digest}"
    end

    def subject
      "password confirmation, #{user.name}"
    end
  end
end
