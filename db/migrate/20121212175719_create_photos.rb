class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :link
      t.boolean :is_legal

      t.timestamps
    end
  end
end
