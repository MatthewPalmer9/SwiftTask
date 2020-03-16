class WelcomeController < ApplicationController
    def index
        @user = User.find_by(id: session[:user_id])
        binding.pry
    end 
end 