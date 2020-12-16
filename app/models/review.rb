class Review < ApplicationRecord
  validates :speciality, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 25 }
  validates :knowledge, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 25 }
  validates :story, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 25 }
  validates :like, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 25 }
  validates :summary, presence: true
  validates :body, presence: true, length: { minimum: 5 }
  validates :book_id, presence: true, uniqueness: { scope: [:user_id] }
  validates :user_id, presence: true

  belongs_to :book, foreign_key: :book_id
  belongs_to :user, foreign_key: :user_id
end
