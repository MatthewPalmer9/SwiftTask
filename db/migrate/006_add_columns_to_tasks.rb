class AddColumnsToTasks < ActiveRecord::Migration[5.2]
    def change
        add_column :tasks, :assigned_by, :integer
    end 
end 