require 'rails_helper'

RSpec.describe 'favorite function', type: :feature do
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

  feature 'book detail screen' do
    context 'when you press the favorite button' do
      it 'cancel favorite button is displayed' do
        visit book_path(@book.id)
        click_on 'favorite'
        expect(page).to have_content "cancel favorite"
      end
    end
  end
end
