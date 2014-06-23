class CreateApiTypes < ActiveRecord::Migration
  def change
    create_table :api_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
