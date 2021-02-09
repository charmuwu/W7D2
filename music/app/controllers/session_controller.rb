class SessionsController < ApplicationController
    def create
        @user = User.find_by_credentials(
            params[:user][:email]
            params[:user][:password]
        )
        if @user
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.new[:errors] = @user.errors.full_messages
            redirect_to new_session_url
        end
    end
    def new
        @user = User.new
        render :new
    end
    def destroy
    end
end