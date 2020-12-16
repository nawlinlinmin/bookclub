require 'rails_helper'

RSpec.describe Book, type: :model do
  it "is valid with a title, author, genre, price" do
    book = Book.new(title: "title", author: "author", price: 5000, genre: 5, released_at: "2020-12-05", story: "story", icon: "icon_URL")
    expect(book).to be_valid
  end

  it "is invalid without a title" do
    book = Book.new(author: "author", price: 5000, genre: 5, released_at: "2020-12-05", story: "story", icon: "icon_URL")
    expect(book).not_to be_valid
  end

  it "is invalid without a author" do
    book = Book.new(title: "title", price: 5000, genre: 5, released_at: "2020-12-05", story: "story", icon: "icon_URL")
    expect(book).not_to be_valid
  end

  it "is invalid without a genre" do
    book = Book.new(title: "title", author: "author", price: 5000, released_at: "2020-12-05", story: "story", icon: "icon_URL")
    expect(book).not_to be_valid
  end

    it "is valid without a price because of default value" do
      book = Book.new(title: "title", author: "author", genre: 5, released_at: "2020-12-05", story: "story", icon: "icon_URL")
      expect(book).to be_valid
    end

  it "is valid without a released_at, story or icon" do
    book = Book.new(title: "title", author: "author", price: 5000, genre: 5)
    expect(book).to be_valid
  end

  it "is invalid with a duplicate title" do
    Book.create(title: "title", author: "author5", price: 5000, genre: 5, released_at: "2020-12-05")
    book = Book.new(title: "title", author: "author", price: 5000, genre: 5,released_at: "2020-12-05")
    expect(book).not_to be_valid
  end

  it "is invalid with string in price" do
    book = Book.new(title: "title", author: "author", price: "String", genre: 6, released_at: "2020-12-05")
    expect(book).not_to be_valid
  end
end
