class CreateTaskGroups < ActiveRecord::Migration[5.2]
    def change 
        create_table :task_groups do |t|
            t.string :group_name
            t.integer :user_id
            t.integer :task_manager_id

            t.timestamps null: false

        end 
    end 
end 