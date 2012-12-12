class AddSidToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :sid, :string
  end
end
