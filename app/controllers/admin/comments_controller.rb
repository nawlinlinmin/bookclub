class Admin::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin?
  before_action :set_comment, only: [:edit, :update]

  def index
    @comments = Comment.all
  end

  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to admin_book_path(@book.id), notice: "Couldn't post ..." }
      end
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id], book_id: params[:book_id])
    comment.destroy
    redirect_to admin_book_path(params[:book_id]), notice:"The review has been deleted!"
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to admin_book_path(@comment.book_id), notice: "Edited the comment！"
    else
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :book_id, :user_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
