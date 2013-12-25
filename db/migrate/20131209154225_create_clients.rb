class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :company_name
      t.string :contact_person
      t.string :email
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.float  :longitude
      t.float  :latitude
      t.string :website
      t.string :title
      t.string :slogan
      t.string :phone_number
      t.string :description
      t.float  :logo

      t.timestamps
    end
  end
end
