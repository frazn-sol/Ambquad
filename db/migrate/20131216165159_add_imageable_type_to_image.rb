class AddImageableTypeToImage < ActiveRecord::Migration
  def change
    add_column :images, :imageable_type, :string
  end
end
