class CreateInviteCodes < ActiveRecord::Migration
  def change
    create_table :invite_codes do |t|
      t.string :code
      t.boolean :consumed, :default => false
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
