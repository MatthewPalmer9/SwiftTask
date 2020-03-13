class TaskGroup < ActiveRecord::Base
    has_many :tasks
    has_many :users, through: :tasks
    belongs_to :task_manager
end 