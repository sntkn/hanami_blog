module Mailers
  class Welcome
    include Hanami::Mailer

    from    'noreply@bookshelf.org'
    to      :recipient
    subject :subject
    template 'welcome'

    private

    def recipient
      user.email
    end

    def activation_url
      Web.routes.activate_user_url + '?activation_digest=' + user.activation_digest
    end

    def subject
      "Welcome #{user.name}"
    end
  end
end
