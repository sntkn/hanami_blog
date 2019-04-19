module Web
  module Authentication
    def self.included(action)
      action.class_eval do
        before :authenticate!
        expose :current_user
      end
    end

    private

    def authenticate!
      halt 401 unless authenticated? || !defined? required_authentication
    end

    def authenticated?
      !!current_user
    end

    def current_user
      @current_user ||= UserRepository.new.find_by_token(token: session[:token]).first
    end

    def token_session(token)
      session[:token] = token
    end

    def sign_out
      session[:token] = nil
    end
  end
end
