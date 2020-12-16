require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @book = Book.create(title: "title", author: "author", price: 5000, genre: 5, released_at: "2020-12-05", story: "story", icon: "icon_URL")
    @user= User.new(name: "name", introduce: "introduce", icon: "icon_URL", admin: false, email: "test@e.mail", password: "password")
    # @user.skip_confirmation!
    @user.save
  end

  it "is valid with a book_id and user_id" do
    favorite = Favorite.create(book_id: @book.id, user_id: @user.id)
    expect(favorite).to be_valid
  end

  it "is invalid without a book_id" do
    favorite = Favorite.create(user_id: @user.id)
    expect(favorite).not_to be_valid
  end

  it "is invalid without an user_id" do
    favorite = Favorite.create(book_id: @book.id)
    expect(favorite).not_to be_valid
  end

  it "is invalid if book doesn't exist" do
    favorite = Favorite.create(book_id: @book.id + 1, user_id: @user.id)
    expect(favorite).not_to be_valid
  end

  it "is invalid if user doesn't exist" do
    favorite = Favorite.create(book_id: @book.id, user_id: @user.id + 1)
    expect(favorite).not_to be_valid
  end
end
