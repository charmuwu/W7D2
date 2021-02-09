class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?
    #lets views call these methods

    def login!(user)
        session[:session_token] = user.reset_session_token!
        #sets session token in cookies to new session token on login
    end
    def current_user
        #return the current user
        @current_user ||= User.find_by(session_token: session[:session_token])
        #sets the current_user to what's the cookie's session token is 
    end
    def logged_in?
        #return a boolean indicating whether someone is signed in
        !!current_user
    end
    def logout!
        current_user.reset_session_token! if logged_in?
        session[:session_token] = nil #delets the session token from cookies
        @current_user = nil #sets current user to nothing.
    end
end
