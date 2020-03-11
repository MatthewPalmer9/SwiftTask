class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    def log_in(user)
      session[:user_id] = user.id
      flash[:success] = "Login Successful!"
    end

    def log_out
      session.delete(:user_id)
      @current_user = nil
    end

    def active_session?
      !session[:user_id].empty?
    end 

    def logged_in?
      if find_user.nil?
        redirect_to root_path
      end
    end
  
    def find_user
      @user ||= User.find(session[:user_id])
    end

    def signup_user(user)
      if user.save
        log_in user
        flash[:success] = "Welcome to Swift Task!"
        redirect_to '/'
      else
        flash[:errors] = user.errors.full_messages
        redirect_to '/'
      end
    end

  end