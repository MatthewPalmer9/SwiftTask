class Project < ActiveRecord::Base
    validates :name, presence: true

    has_many :tasks
    has_many :users, through: :tasks

    scope :filter_by_starts_with, -> (name) { where("name like ?", "#{name.downcase}%")}

    def self.search(search)
        if search.nil? || search.empty?
            flash[:error] = "Search field left blank."
            redirect_to projects_path
        else
            if search
                search_param = Project.find_by(name: search)
                if search_param
                    @result = search_param
                    redirect_to "/project/search"
                else
                    flash[:error] = "No project exists with that name."
                    redirect_to projects_path
                end
            end
        end 
    end 
end 