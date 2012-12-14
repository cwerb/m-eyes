class AddSidToAuthor < ActiveRecord::Migration
  def change
    add_column :authors, :sid, :string
  end
end
