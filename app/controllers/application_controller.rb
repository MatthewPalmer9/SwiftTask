class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    helper_method :current_user, :task_owner, :require_login

    def log_in(user)
      session[:user_id] = user.id
      flash[:success] = "Login Successful!"
    end

    def log_out
      session.delete(:user_id)
      @current_user = nil
    end

    def current_user
      @user = User.find_by(id: session[:user_id])
    end

    def require_login
      # return head(:forbidden) unless session.include? :user_id
      if current_user.nil?
          flash[:success] = "You must be logged in to perform this action."
          redirect_to root_path
      end 
    end

    def require_owner
      if current_user.id != this_project.user_project_id
        flash[:error] = "You do not have permission to perform this action."
        redirect_to projects_path
      end 
    end 

    def task_owner(task)
      User.find_by(id: task.assigned_by).first_name
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