class AddAccountTypeToClient < ActiveRecord::Migration
  def change
    add_column :clients, :account_type, :string
  end
end
