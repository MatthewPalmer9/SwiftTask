class UsersController < ApplicationController
    before_action :require_login, except: [:create, :new]

    def most_projects
        @most_projects = User.most_projects
    end 

    def dashboard
    end 

    def new
        @user = User.new
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