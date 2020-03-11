class SessionsController < ApplicationController
    def new
    end 

    def create
        @user = User.find_by(:email => params[:session][:email])
        if @user && @user.authenticate(params[:session][:password])
            log_in @user
            redirect_to '/'
        else 
            redirect_to :login
        end 
    end 

    def destroy 
        session.delete(:user_id)
        redirect_to '/'
    end 
end 