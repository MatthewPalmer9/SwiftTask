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

    def facebook
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
            u.name = auth['info']['name']
            u.email = auth['info']['email']
            u.image = auth['info']['image']
            u.provider = "facebook"
        end
        session[:user_id] = @user.id
      
        redirect_to '/'
    end 

    def destroy 
        session.delete(:user_id)
        redirect_to '/'
    end 

    private 

    def auth
        request.env['omniauth.auth']
    end 
end 