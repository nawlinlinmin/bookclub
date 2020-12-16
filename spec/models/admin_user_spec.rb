require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @book = Book.create(title: "title", author: "author", price: 5000, genre: 5, released_at: "2020-05-05", story: "story", icon: "icon_URL")

    @user= User.new(name: "name", introduce: "introduce", icon: "icon_URL", admin: false, email: "test@e.mail", password: "password")
    # @user.skip_confirmation!
    @user.save
  end

  context 'When a user is deleted' do
    it "deletes reviews associated with that user" do
      Review.create(speciality: 1, knowledge: 1, story: 1, like: 1, summary: "summary", body: "review_body", book_id: @book.id, user_id: @user.id)
      expect{ @user.destroy }.to change{ Review.count }.by(-1)
    end

    it "deletes comments associated with that user" do
      comment = Comment.create(body: "body", book_id: @book.id, user_id: @user.id)
      expect{ @user.destroy }.to change{ Comment.count }.by(-1)
    end

    it "deletes favorites associated with that user" do
      favorite = Favorite.create(book_id: @book.id, user_id: @user.id)
      expect{ @user.destroy }.to change{ Favorite.count }.by(-1)
    end

  end
end
