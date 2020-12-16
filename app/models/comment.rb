class Comment < ApplicationRecord
  validates :body, presence: true
  validates :book_id, presence: true
  validates :user_id, presence: true

  belongs_to :book, foreign_key: :book_id
  belongs_to :user, foreign_key: :user_id
end
