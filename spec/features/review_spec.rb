require 'rails_helper'

RSpec.describe 'review management function', type: :feature do
  before do
    @book = Book.create(title: "title", author: "author", price: 5000, genre: 5, released_at: "2020-05-05", story: "story", icon: "icon_URL")
    @user= User.new(name: "name", introduce: "introduce", icon: "icon_URL", admin: false, email: "test@e.mail", password: "password")
    # @user.skip_confirmation!
    @user.save

    visit new_user_session_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    find(".login_button").click
  end


  feature 'review detail screen' do
    context 'when transistioning to any book detail screen' do
      it 'transit to the page where the content, reviews, and comments of the book are displayed' do
        @review = Review.create(speciality: 1, knowledge: 1, story: 1, like: 1, summary: "summary", body: "review_body", book_id: @book.id, user_id: @user.id)
        visit review_path(@review.id)

        expect(page).to have_content @review.summary
        expect(page).to have_content @review.speciality
        expect(page).to have_content @review.knowledge
        expect(page).to have_content @review.story
        expect(page).to have_content @review.like
        expect(page).to have_content @review.speciality + @review.knowledge + @review.story + @review.like
        expect(page).to have_content @review.body
      end
    end
  end
end
