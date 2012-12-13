class AddHashtagToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :hashtag, :string
  end
end
