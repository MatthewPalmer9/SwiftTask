class CreateProjects < ActiveRecord::Migration[5.2]
    def change 
        create_table :projects do |t|
            t.string :name
            t.integer :user_project_id

            t.timestamps null: false
        end 
    end 
end 