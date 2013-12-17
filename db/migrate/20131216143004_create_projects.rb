class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_name
      t.string :project_status
      t.date :start_date
      t.date :completion_date
      t.string :project_value
      t.string :city
      t.string :state
      t.string :country
      t.string :client
      t.string :description
      t.belongs_to :client

      t.timestamps
    end
  end
end
