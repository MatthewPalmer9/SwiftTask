class TasksController < ApplicationController
    before_action :require_login
    before_action :set_task, only: [:edit, :update, :destroy, :complete]
  
    def index
        @tasks = current_user.tasks
        @project = Project.find_by(:user_project_id => current_user.id) 
    end
  
    def new
        @task = Task.new(user_id: @user.id)
    end
  
    def create
        current_user
        @task = Task.new(task_params)
        @task.assigned_by = current_user.id
        if @task.save
            redirect_to projects_path
        else
            render :new
        end
    end
  
    def edit

    end
  
    def update
      if @task.update(task_params)
        redirect_to projects_path
      else
        render :edit
      end
    end
  
    def complete
        if current_user.id == @task.user_id
            @task.update(completed: true)
            redirect_to '/tasks'
        else
            binding.pry
            flash[:error] = "You cannot complete a task that was not assigned to you."
            redirect_to '/tasks'
        end 
    end
  
    def destroy
        if current_user.id != this_task.user_id
            flash[:error] = "You cannot destroy a task that doesn't belong to you."
            redirect_to projects_path
        end 
        Task.find(params[:id]).destroy
        redirect_to tasks_path
    end
  
    private
  
    def set_task
        @task = Task.find(params[:id])
    end

    def this_task
        Task.find(params[:id])
    end 
  
    def task_params
        params.require(:task).permit(:due_date, :description, :user_id, :project_id)
    end
  
    def require_login
        # return head(:forbidden) unless session.include? :user_id
        if current_user.nil?
            flash[:error] = "You must be logged in to view tasks."
            redirect_to root_path
        end 
    end
end
  