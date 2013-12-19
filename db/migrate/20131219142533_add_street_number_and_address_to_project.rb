class AddStreetNumberAndAddressToProject < ActiveRecord::Migration
  def change
    add_column :projects, :street_number, :string
    add_column :projects, :address, :string
  end
end
