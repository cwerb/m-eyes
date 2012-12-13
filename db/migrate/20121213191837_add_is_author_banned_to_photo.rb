class AddIsAuthorBannedToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :is_author_banned, :boolean
  end
end
