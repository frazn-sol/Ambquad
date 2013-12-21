class RenameAddressColumnName < ActiveRecord::Migration
  def up
  	rename_column :clients, :street_number, :address1
  	rename_column :clients, :address, :address2
  	rename_column :projects, :street_number, :address1
  	rename_column :projects, :address, :address2
  end

  def down
  end
end
