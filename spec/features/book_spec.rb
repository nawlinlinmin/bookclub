require 'rails_helper'

RSpec.describe 'book management function', type: :feature do
  before do
    @book = Book.create(title: "title", author: "author", price: 5000, genre: 5, released_at: "2020-12-05", story: "story", icon: "icon_URL")
    @user= User.new(name: "name", introduce: "introduce", icon: "icon_URL", admin: false, email: "test@e.mail", password: "password")
    # @user.skip_confirmation!
    @user.save

    visit new_user_session_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    find(".login_button").click
  end

  feature 'book list screen' do
    context 'if you have already registered the book' do
      scenario 'registered tasks should be displayed' do
        visit books_path
        expect(page).to have_content 'title'
      end
    end

    context 'if you created multiple books' do
      it 'books are arranged in descending order of creation date and time' do
        @book2 = Book.create(title: "title2", author: "author2", price: 5000, genre: 5, released_at: "2020-12-05", story: "story", icon: "icon_URL")
        visit books_path
        book_list = all('.book_row')
        expect(book_list[0]).to have_content 'title2'
        expect(book_list[1]).to have_content 'title'
      end

      it 'search function by title or author' do
        @search_book = Book.create(title: "search_title", author: "search_author", price: 5000, genre: 5, released_at: "2020-12-05", story: "story", icon: "icon_URL")
        @miss_book = Book.create(title: "miss_title", author: "miss_author", price: 5000, genre: 5, released_at: "2020-12-05", story: "story", icon: "icon_URL")
        visit books_path
        # save_and_open_page
        # fill_in "title_or_author", with: "search"
        find(".search_title_or_author_form").set("search")
        click_on 'search'
        expect(page).to have_content 'search'
        expect(page).not_to have_content 'miss'
      end
    end
  end


  feature 'book detail screen' do
    context 'when transistioning to any book detail screen' do
      it 'transit to the page where the content, reviews, and comments of the book are displayed' do
        Review.create(speciality: 1, knowledge: 1, story: 1, like: 1, summary: "summary", body: "review_body", book_id: @book.id, user_id: @user.id)
        Comment.create(body: "body", book_id: @book.id, user_id: @user.id)

        books = Book.all
        books.each do |book|
          visit book_path(book.id)
          # save_and_open_page

          expect(page).to have_content book.title
          expect(page).to have_content book.author
          expect(page).to have_content book.genre_i18n
          expect(page).to have_content book.price

          book.reviews.each do |review|
            expect(page).to have_content review.user.name
            expect(page).to have_content review.summary
            expect(page).to have_content review.speciality + review.knowledge + review.story + review.like
          end

          book.comments.each do |comment|
            expect(page).to have_content comment.body
            expect(page).to have_content comment.user.name
          end
        end
      end
    end
  end
end
