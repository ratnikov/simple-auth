class CreateUserAuth < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string   :encrypted_password, :limit => 128
      t.string   :salt,               :limit => 128
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
