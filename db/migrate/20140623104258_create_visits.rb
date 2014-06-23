class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :browser
      t.integer :api_type_id
      t.integer :client_id

      t.timestamps
    end
  end
end
