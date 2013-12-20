class AddClientIdToShotenedLink < ActiveRecord::Migration
  def change
    add_column :shotened_links, :client_id, :integer
    add_column :shotened_links, :url, :string, :null => false
    add_column :shotened_links, :unique_key, :string, :null => false 
    add_column :shotened_links, :use_count, :integer, :null => false, :default => 0
       
  end
end
