class Admin::BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin?

  def index
    # binding.pry

    unless params[:q].nil?
      if params[:q][:price_gteq].present? && params[:q][:price_lt].present?
        if params[:q][:price_gteq] > params[:q][:price_lt]
          flash[:notice] = "Please enter the price search range correctly."
          redirect_to books_path
        end
      end

      if params[:q][:released_at_gteq].present? && params[:q][:released_at_lteq].present?
        if params[:q][:released_at_gteq].to_time > params[:q][:released_at_lteq].to_time
        flash[:notice] = "Please enter the search range for the release date correctly."
          redirect_to books_path
        end
      end
    end

    @q = Book.ransack(params[:q])
    if params[:order_by_speciality]
      @books = Book.select('books.*', 'sum(reviews.speciality) * 4 / count(reviews.id) AS reviews').left_joins(:reviews).group('books.id').order('reviews desc').page(params[:page]).per(100)
      params.delete("order_by_speciality")
    elsif params[:order_by_knowledge]
      @books = Book.select('books.*', 'sum(reviews.knowledge) * 4 / count(reviews.id) AS reviews').left_joins(:reviews).group('books.id').order('reviews desc').page(params[:page]).per(100)
      params.delete("order_by_knowledge")
    elsif params[:order_by_story]
      @books = Book.select('books.*', 'sum(reviews.story) * 4 / count(reviews.id) AS reviews').left_joins(:reviews).group('books.id').order('reviews desc').page(params[:page]).per(100)
      params.delete("order_by_story")
    elsif params[:order_by_like]
      @books = Book.select('books.*', 'sum(reviews.like) * 4 / count(reviews.id) AS reviews').left_joins(:reviews).group('books.id').order('reviews desc').page(params[:page]).per(100)
      params.delete("order_by_like")
    elsif params[:order_by_sum]
      @books = Book.select('books.*', '(sum(reviews.speciality) + sum(reviews.knowledge) + sum(reviews.story) + sum(reviews.like)) / count(reviews.id) AS reviews')
      .left_joins(:reviews).group('books.id').order('reviews desc').page(params[:page]).per(100)
      params.delete("order_by_sum")
    elsif params[:order_by_reviews]
      @books = Book.select('books.*', 'count(reviews.id) AS reviews').left_joins(:reviews).group('books.id').order('reviews desc').page(params[:page]).per(100)
      params.delete("order_by_reviews")
    else
      @q.sorts = 'created_at desc' if @q.sorts.empty?
      @books = @q.result(distinct: true).page(params[:page]).per(10)
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if params[:back]
      render :new
    else
      if @book.save
        redirect_to admin_book_path(@book.id), notice: "You created a book!"
      else
        render :new
      end
    end
  end

  def show
    @comments = @book.comments
    @comment = @book.comments.build
    @favorite = current_user.favorites.find_by(book_id: @book.id)
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to admin_book_path(@book.id), notice: "You edited a book!"
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to admin_books_path, notice:"You deleted a book！"
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre, :price, :released_at, :story, :icon, :icon_cache)
  end

  def search_params
    params.require(:q).permit(:title_or_author_cont, :price_gteq, :price_lt, :genre_eq, :released_at_gteq, :released_at_lteq)
  end

  def set_book
    @book = Book.find(params[:id])
  end

end
