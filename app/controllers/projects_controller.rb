class ProjectsController < ApplicationController
    before_action :require_login
    before_action :set_project, only: [:show, :edit, :update, :destroy]

    def index
        current_user
        @projects = Project.all
        @project = Project.find_by(:user_id => @user.id)
    end
  
    def show
        current_user
        @project
        @tasks = @project.tasks
    end
  
    def new
        current_user
        @project = Project.new
    end
  
    def create
        @project = Project.new(project_params)
        @project.user_id = current_user.id
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
        Project.find(params[:id]).destroy
        redirect_to projects_path
    end
  
    private
  
    def set_project
        @project = Project.find(params[:id])
    end
  
    def project_params
        params.require('project').permit(:name, :user_id)
    end
  
    def require_login
        if session[:user_id].nil?
            flash[:error] = "You must be logged in to view projects."
            redirect_to root_path
        end 
    end
end
  