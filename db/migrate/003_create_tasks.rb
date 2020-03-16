class CreateTasks < ActiveRecord::Migration[5.2]
    def change 
        create_table :tasks do |t|
            t.string :name
            t.string :description 
            t.datetime :due_date
            t.boolean :completed, default: false
            t.integer :user_id
            t.integer :project_id

            t.timestamps null: false
        end 
    end 
end 