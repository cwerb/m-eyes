class AddRegisterTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :register_token, :string
  end
end
