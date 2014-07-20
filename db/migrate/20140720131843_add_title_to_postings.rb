class AddTitleToPostings < ActiveRecord::Migration
  def self.up
    add_column :postings, :title, :string
  end

  def self.down
    remove_column :postings, :title
  end
end
