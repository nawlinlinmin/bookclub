require 'rails_helper'

RSpec.describe 'user management function', type: :feature do
  before do
    @book = Book.create(title: "title", author: "author", price: 5000, genre: 5, released_at: "2020-12-05", story: "story", icon: "icon_URL")
    @user= User.new(name: "name", introduce: "introduce", icon: "icon_URL", admin: false, email: "test@e.mail", password: "password")
    # @user.skip_confirmation!
    @user.save
  end

  def log_in
    visit new_user_session_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    find(".login_button").click
  end

  feature 'Sign in (user registration) screen' do
    context 'when registered as a user' do
      it 'Login is also done at the same time' do
        log_in
        expect(page).to have_content "ログインしました"
        expect(page).to have_content "#{@user.name}'s profile"
      end
    end

    context 'when accessing the new user registration screen at login' do
      it 'go to top page' do
        log_in
        visit new_user_session_path
        expect(page).to have_content "すでにログインしています"
      end
    end
  end

  feature 'profile (user details) screen' do
    context 'when accessing the edit page (user # edit) of a user other than yourself (current_user)' do
      it 'go to top page' do
        @user2= User.new(name: "name2", introduce: "introduce2", icon: "icon_URL2", admin: false, email: "test2@e.mail", password: "password2")
        # @user2.skip_confirmation!
        @user2.save
        log_in
        visit edit_user_path(@user2.id)
        expect(page).to have_content "You don't have permission!"
        expect(page).to have_content 'title or author'
        # save_and_open_page
      end
    end
  end

  feature 'user detail screen' do
    context 'when transitioning to any user detail screen' do
      it 'move to the page where the profile information of the user, reviews posted and favorites are displayed' do
        Review.create(speciality: 1, knowledge: 1, story: 1, like: 1, summary: "summary", body: "review_body", book_id: @book.id, user_id: @user.id)
        Favorite.create(book_id: @book.id, user_id: @user.id)

        log_in
        users = User.all
        users.each do |user|
          visit user_path(user.id)
          expect(page).to have_content user.name

          user.reviews.each do |review|
            expect(page).to have_content review.summary
            expect(page).to have_content review.book.title
            expect(page).to have_content review.speciality + review.knowledge + review.story + review.like
          end

          user.favorites.each do |favorite|
            expect(page).to have_content favorite.book.title
            expect(page).to have_content favorite.book.author
          end

        end
      end
    end
  end
end
