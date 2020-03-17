class TasksController < ApplicationController
    before_action :require_login
    before_action :set_task, only: [:edit, :update, :destroy, :complete]
  
    def index
        if session[:user_id]
            if User.find(session[:user_id]) == current_user
                @user = User.find(session[:user_id])
                @tasks = @user.tasks
                @project = Project.find_by(:user_id => @user.id)
            else
                redirect_to projects_path
                flash[:notice] = "Unauthorized Access."
            end
        else
            @tasks = Task.all
        end
    end
  
    def new
      if session[:user_id]
        @user = User.find(session[:user_id])
        @task = Task.new(user_id: @user.id)
      else
        @user = nil
        @task = Task.new
      end
    end
  
    def create
        current_user
        @task = Task.new(task_params)
        if @task.save
            redirect_to projects_path
        else
            render :new
        end
    end
  
    def edit
        current_user
    end
  
    def update
      if @task.update(task_params)
        redirect_to projects_path
      else
        render :edit
      end
    end
  
    def complete
        @task = Task.find(params[:id])
        @task.update(completed: true)
        redirect_to '/tasks'
    end
  
    def destroy
        Task.find(params[:id]).destroy
        redirect_to tasks_path
    end
  
    private
  
    def set_task
        @task = Task.find(params[:id])
    end
  
    def task_params
        params.require(:task).permit(:due_date, :description, :user_id, :project_id)
    end
  
    def require_login
        # return head(:forbidden) unless session.include? :user_id
        if session[:user_id].nil?
            flash[:error] = "You must be logged in to view tasks."
            redirect_to root_path
        end 
    end
end
  