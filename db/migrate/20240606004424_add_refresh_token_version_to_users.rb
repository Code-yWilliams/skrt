class AddRefreshTokenVersionToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :refresh_token_version, :integer, default: 0, null: false
  end
end
