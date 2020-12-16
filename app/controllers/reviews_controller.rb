class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action -> {restrict_access(@review.user_id)}, only: [:edit, :update, :destroy]

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if params[:back]
      render :new
    else
      if @review.save
        redirect_to review_path(@review.id), notice: "You created a review!"
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to review_path(@review.id), notice: "Edited the review!"
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to user_path(@review.user_id), notice:"Deleted the review!"
  end

  private

  def review_params
    params.require(:review).permit(:speciality, :knowledge, :story, :like, :summary, :body, :book_id, :user_id)
  end

  def set_review
    @review = Review.find(params[:id])
  end

end
