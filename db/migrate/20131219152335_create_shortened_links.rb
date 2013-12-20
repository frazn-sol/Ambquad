class CreateShortenedLinks < ActiveRecord::Migration
  def change
    create_table :shortened_links do |t|

      t.timestamps
    end
  end
end
