class Admin::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin?

  def index
    @favorites = Favorite.all
  end

  def create
    favorite = current_user.favorites.create(book_id: params[:book_id])
    redirect_to admin_book_path(favorite.book.id), notice: "#{favorite.book.title}を気になる登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to admin_book_path(favorite.book.id), notice: "#{favorite.book.title}の気になるを解除しました"
  end
end
