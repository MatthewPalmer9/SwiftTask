class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    helper_method :current_user

    def log_in(user)
      session[:user_id] = user.id
      flash[:success] = "Login Successful!"
    end

    def log_out
      session.delete(:user_id)
      @current_user = nil
    end

    def logged_in?
      if current_user 
        redirect_to task_path
      else
        redirect_to root_path
      end
    end

    def current_user
      @user = User.find_by(id: session[:user_id])
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