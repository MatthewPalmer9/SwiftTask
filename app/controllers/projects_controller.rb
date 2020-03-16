class ProjectsController < ApplicationController
    before_action :require_login
    before_action :set_project, only: [:show, :edit, :update, :destroy]

    def index
        current_user
        @projects = Project.all
    end
  
    def show
        current_user
        @tasks = @project.tasks
    end
  
    def new
        current_user
        @project = Project.new
    end
  
    def create
        @project = Project.new(project_params)
        if @project.save
            redirect_to projects_path
        else
            render :new
        end
    end
  
    def edit
    end
  
    def update
        if @project.update(project_params)
            redirect_to projects_path
        else
            render :edit
        end
    end
  
    def destroy
        @project = Project.find(params[:id])
        @project.destroy
        redirect_to projects_path
    end
  
    private
  
    def set_project
        @project = Project.find(params[:id])
    end
  
    def project_params
        params.require('project').permit(:name)
    end
  
    def require_login
        if session[:user_id].nil?
            flash[:error] = "You must be logged in to view this page."
            redirect_to root_path
        end 
    end
end
  