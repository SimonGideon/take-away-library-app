class BorrowingsController < ApplicationController
    before_action :authenticate!
    before_action :set_borrowing, only: [:return]
  
    def index
      @borrowings = Current.user.borrowings.current.includes(:book)
    end
  
    def return
      if @borrowing.update(returned_at: Time.current)
        redirect_to borrowings_path, notice: "Book was successfully returned."
      else
        redirect_to borrowings_path, alert: "There was an error returning the book."
      end
    end
  
    private
  
    def set_borrowing
      @borrowing = Current.user.borrowings.find(params[:id])
    end
  end