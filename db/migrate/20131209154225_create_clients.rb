class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :company_name
      t.string :contact_person
      t.string :email
      t.string :website
      t.string :title
      t.string :slogan
      t.string :phone_number
      t.string :description

      t.timestamps
    end
  end
end
