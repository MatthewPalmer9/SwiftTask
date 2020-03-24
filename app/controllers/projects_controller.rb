class ProjectsController < ApplicationController
    before_action :require_login
    before_action :set_project, only: [:show, :edit, :update, :destroy]

    def index
        @projects = Project.all
    end
  
    def show
        if !@project.nil?
            @tasks = @project.tasks
        else 
            flash[:success] = "An error occured. Please try again."
            redirect_to projects_path
        end 
    end
  
    def new
        @project = Project.new
    end
  
    def create
        @project = Project.new(project_params)
        @project.user_project_id = current_user.id
        if @project.save
            redirect_to projects_path
        else
            render :new
        end
    end
  
    def edit
        if current_user.id != this_project.user_project_id
            flash[:error] = "You cannot edit a project that doesn't belong to you."
            redirect_to projects_path
        end 
    end
  
    def update
        if @project.update(project_params)
            redirect_to projects_path
        else
            render :edit
        end
    end
  
    def destroy
        if current_user.id != this_project.user_project_id
            flash[:error] = "You cannot destroy a project that doesn't belong to you."
            redirect_to projects_path
        else
            Project.find(params[:id]).destroy
            redirect_to projects_path
        end 
    end
  
    private
  
    def set_project
        if params[:name]
            @project = Project.find_by(name: params[:name])
        elsif params[:id]
            @project = Project.find(params[:id])
        else 
            flash[:error] = "Project either does not exist or an error occuredn. Please check your spelling."
            redirect_to projects_path
        end 
    end

    def this_project 
        Project.find(params[:id])
    end 
  
    def project_params
        params.require('project').permit(:name, :user_id)
    end
  
    def require_login
        if current_user.nil?
            flash[:error] = "You must be logged in to view projects."
            redirect_to root_path
        end 
    end
end
  