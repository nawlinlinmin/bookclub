class ContactsController < ApplicationController
  before_action :set_inform, only: [:show, :edit, :update, :destroy]
  
  def create
    @inform = Contact.new(inform_params)
    if @inform.save
      ContactMailer.inform_mail(@inform).deliver
      redirect_to informs_path, notice: 'Contact was successfully created.'
    else
      render :new
    end
  end

  private

  def set_inform
    @inform = Contact.find(params[:id])
  end

  def inform_params
    params.require(:inform).permit(:email, :book, :review)
  end
end
