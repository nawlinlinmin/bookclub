class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :speciality, null: false, default: 10
      t.integer :knowledge, null: false, default: 10
      t.integer :story, null: false, default: 10
      t.integer :like, null: false, default: 10
      t.string :summary, null: false
      t.text :body, null: false
      t.integer :book_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
