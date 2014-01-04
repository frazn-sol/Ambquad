class AddTemplateToClient < ActiveRecord::Migration
  def change
    add_column :clients, :template, :string
  end
end
