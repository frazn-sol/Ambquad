class AddConfirmationToClient < ActiveRecord::Migration
  def change
  	add_column :clients, :confirmation_token, :string
    add_column :clients, :confirmed_at, :datetime
    add_column :clients, :unconfirmed_email, :string
    add_column :clients, :confirmation_sent_at, :datetime
  end
end
