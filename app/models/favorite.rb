class Favorite < ApplicationRecord
  validates :book_id, presence: true, uniqueness: { scope: [:user_id] }
  validates :user_id, presence: true


  belongs_to :book, foreign_key: :book_id
  belongs_to :user, foreign_key: :user_id
end
