class UsersController < ApplicationController

    def dashboard
        @user = User.find_by(id: session[:user_id])
    end 

    def new
        @user = User.new
    end

    def show
    end 

    def index
        @user = User.find_by(id: session[:user_id])
    end 

    def create
        @user = User.new(user_params)
        #This below can be found in application controller
        signup_user(@user)
    end
    
    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :uid, :name, :image, :provider)
    end 
end 