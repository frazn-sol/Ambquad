class AddCityAndStateAndCountryToClient < ActiveRecord::Migration
  def change
    add_column :clients, :city, :string
    add_column :clients, :state, :string
    add_column :clients, :country, :string
  end
end
