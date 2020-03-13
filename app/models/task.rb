class Task < ActiveRecord::Base
    belongs_to :user
    belongs_to :task_manager
    belongs_to :task_group
    
end 