class AddStreetNumberAndAddressToClient < ActiveRecord::Migration
  def change
    add_column :clients, :street_number, :string
    add_column :clients, :address, :string
  end
end
