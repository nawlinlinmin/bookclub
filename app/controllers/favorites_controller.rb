class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    favorite = current_user.favorites.create(book_id: params[:book_id])
    redirect_to book_path(favorite.book.id), notice: "#{favorite.book.title}を気になる登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id])
    restrict_access(favorite.user_id)
    favorite.destroy
    redirect_to book_path(favorite.book.id), notice: "#{favorite.book.title}の気になるを解除しました"
  end
end
