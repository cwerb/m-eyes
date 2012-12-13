class AddAuthorIdToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :author_id, :integer
  end
end
