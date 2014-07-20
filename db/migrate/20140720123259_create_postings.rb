class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.string "url", null: false
      t.text "body"
      t.string "tags", default: [], array: true
      t.timestamps
    end
  end
end
