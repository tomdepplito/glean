class AddSourceToPostings < ActiveRecord::Migration
  def self.up
    add_column :postings, :source, :string, null: false
  end

  def self.down
    remove_column :postings, :source
  end
end
