class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image
      t.references :imageable

      t.timestamps
    end
    add_index :images, :imageable_id
  end
end
