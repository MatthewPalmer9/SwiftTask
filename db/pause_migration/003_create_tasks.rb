class CreateTasks < ActiveRecord::Migration[5.2]
    def change 
        create_table :tasks do |t|
            t.string :task_name
            t.string :task_description 
            t.integer :user_id
            t.integer :task_manager_id

            t.timestamps null: false
        end 
    end 
end 