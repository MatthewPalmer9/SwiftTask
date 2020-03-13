class TaskManager < ActiveRecord::Base
    has_many :tasks
    has_many :users, through: :tasks 
    has_many :task_groups
    has_many :users, through: :task_groups
end 