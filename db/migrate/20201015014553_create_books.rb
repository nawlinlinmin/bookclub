class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.integer :genre, null: false
      t.integer :price, null: false, default: 5000
      t.date :released_at
      t.text :story
      t.text :icon

      t.timestamps
    end
  end
end
