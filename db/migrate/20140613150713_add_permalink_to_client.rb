class AddPermalinkToClient < ActiveRecord::Migration
  def change
    add_column :clients, :permalink, :string
  end
end
