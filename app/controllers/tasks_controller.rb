class TasksController < ApplicationController

    def index 
        current_user
        @tasks = Task.all
    end 

    def new
        current_user
        @task = Task.new
        @task.user_id = current_user.id
    end 

    def show
        current_user
        @task = Task.find_by(params[:id])
    end 

    def create
        current_user
        @task = Task.create(task_params)
        @task.user_id = current_user.id
        @task.task_manager_id = current_user.id
        binding.pry
        redirect_to '/users/:id/tasks'
    end 

    def destroy
        @task = Task.find_by(params[:id])
        @task.destroy 

        redirect_to '/'
    end 

    private

    def task_params
        params.require(:task).permit(:task_name, :task_description, :user_id, :task_manager_id)
    end 
end 