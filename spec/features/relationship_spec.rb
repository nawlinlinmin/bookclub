require 'rails_helper'

RSpec.describe 'follow function', type: :feature do
  before do
    @user1 = User.new(name: "name1", introduce: "introduce1", icon: "icon_URL1", admin: false, email: "test1@e.mail", password: "password1")
    # @user1.skip_confirmation!
    @user1.save

    @user2 = User.new(name: "name2", introduce: "introduce2", icon: "icon_URL2", admin: false, email: "test2@e.mail", password: "password2")
    # @user2.skip_confirmation!
    @user2.save


    visit new_user_session_path
    fill_in "Email", with: @user1.email
    fill_in "Password", with: @user1.password
    find(".login_button").click
  end

  feature 'user detail screen' do
    context 'when you follow other user' do
      it 'the names of other users you followed are displayed' do
        relationship = Relationship.create(follower_id: @user1.id, followed_id: @user2.id)
        visit user_path(@user1.id)
        expect(page).to have_content @user2.name
      end
    end

    context 'when you are followed' do
      it 'the names of other users who followed you are displayed' do
        relationship = Relationship.create(follower_id: @user1.id, followed_id: @user2.id)
        visit user_path(@user2.id)
        expect(page).to have_content @user1.name
      end
    end

  end
end
