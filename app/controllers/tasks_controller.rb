class TasksController < ApplicationController
    def new
        @task = Task.new
    end 

    def create
        @task = Task.create(task_params)
        redirect_to task_path(@task)
    end 

    def destroy
        @task = Task.find_by(params[:id])
        @task.destroy 

        redirect_to '/'
    end 
end 