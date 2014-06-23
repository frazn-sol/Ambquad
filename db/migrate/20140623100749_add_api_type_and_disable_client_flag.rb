class AddApiTypeAndDisableClientFlag < ActiveRecord::Migration
  def change
    add_column :clients, :api_type_id, :int
    add_column :clients, :disable_flag, :boolean, :deault => false
  end
end
