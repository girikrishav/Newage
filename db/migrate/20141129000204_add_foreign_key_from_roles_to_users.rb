class AddForeignKeyFromRolesToUsers < ActiveRecord::Migration
  def change
    add_foreign_key(:admin_users, :roles, column: 'role_id')
  end
end
