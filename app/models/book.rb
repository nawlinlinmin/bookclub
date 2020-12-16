class Book < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :price, presence: true, numericality: { only_integer: true }

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :own_users, through: :owns, source: :user

  enum genre: { action: 1, comedy: 2, school_life: 3, adventure: 4, drama: 5, fantasy: 6, supernatural: 7,
                tragedy: 8, mystery: 9, seinen: 10, scifi: 11, romance: 12, yaoi: 13, other: 14
              }

  scope :recent, -> { order(id: :desc).limit(5) }

  # ransacker :speciality_score do
  #   query = '(SELECT AVG(reviews.speciality) FROM reviews WHERE reviews.book_id = book.id GROUP BY reviews.book_id)'
  #   Arel.sql(query)
  # end

  # ransacker :reviews_count do
  #   query = '(SELECT AVG(reviews.speciality) FROM reviews WHERE reviews.book_id = book.id GROUP BY reviews.book_id)'
  #   Arel.sql(query)
  # end

  # COLUMN_NAME_SEARCH_MAP = {
  #   "a" => [1],
  #   "b" => [2,3],
  #   "c" => [4,5]
  # }

  # ransacker :column_name_search, formatter: proc { |v| COLUMN_NAME_SEARCH_MAP[v.to_sym] } do |parent|
  #   parent.table[:column_name]
  # end

  mount_uploader :icon, IconUploader
end
