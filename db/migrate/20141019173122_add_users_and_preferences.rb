class AddUsersAndPreferences < ActiveRecord::Migration
  def self.up
    enable_extension "uuid-ossp"

    create_table :users, id: :uuid do |t|
      t.string :email, unique: true
      t.string :password_salt
      t.string :password_hash
      t.timestamps
    end

    add_index :users, :email, unique: true

    create_table :preferences, id: :uuid do |t|
      t.string :user_id, unique: true
      t.string "subjects", default: [], array: true
      t.timestamps
    end

    add_index :preferences, :user_id, unique: true
  end

  def self.down
    disable_extension "uuid_ossp"
    drop_table :users
    drop_table :preferences
  end
end
