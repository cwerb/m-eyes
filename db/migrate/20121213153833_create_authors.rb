class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :nickname
      t.boolean :is_banned

      t.timestamps
    end
  end
end
