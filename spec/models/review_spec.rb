require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @book = Book.create(title: "title", author: "author", price: 5000, genre: 5, released_at: "2020-12-05", story: "story", icon: "icon_URL")
    @user= User.new(name: "name", introduce: "introduce", icon: "icon_URL", admin: false, email: "test@e.mail", password: "password")
    # @user.skip_confirmation!
    @user.save
  end

  it "is valid with a speciality, knowledge, story, like, summary, body, book_id and user_id" do
    review = Review.new(speciality: 1, knowledge: 1, story: 1, like: 1, summary: "summary", body: "review_body", book_id: @book.id, user_id: @user.id)
    expect(review).to be_valid
  end

  it "is valid without setting speciality, knowledge, story or like because of default value" do
    review = Review.new(summary: "summary", body: "review_body", book_id: @book.id, user_id: @user.id)
    expect(review).to be_valid
  end

  it "is invalid without a summary" do
    review = Review.new(speciality: 1, knowledge: 1, story: 1, like: 1, body: "review_body", book_id: @book.id, user_id: @user.id)
    expect(review).not_to be_valid
  end

  it "is invalid without a body" do
    review = Review.new(speciality: 1, knowledge: 1, story: 1, like: 1, summary: "summary", book_id: @book.id, user_id: @user.id)
    expect(review).not_to be_valid
  end

  it "is invalid without a book_id" do
    review = Review.new(speciality: 1, knowledge: 1, story: 1, like: 1, summary: "summary", body: "review_body", user_id: @user.id)
    expect(review).not_to be_valid
  end

  it "is invalid without a user_id" do
    review = Review.new(speciality: 1, knowledge: 1, story: 1, like: 1, summary: "summary", body: "review_body", book_id: @book.id)
    expect(review).not_to be_valid
  end

  it "is invalid if book doesn't exist" do
    review = Review.new(speciality: 1, knowledge: 1, story: 1, like: 1, summary: "summary", body: "review_body", book_id: @book.id + 1, user_id: @user.id)
    expect(review).not_to be_valid
  end

  it "is invalid if user doesn't exist" do
    review = Review.new(speciality: 1, knowledge: 1, story: 1, like: 1, summary: "summary", body: "review_body", book_id: @book.id, user_id: @user.id + 1)
    expect(review).not_to be_valid
  end

end
