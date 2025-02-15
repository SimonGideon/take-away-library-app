class BorrowingsController < ApplicationController
  before_action :set_borrowing, only: [:return]

  def index
    @borrowings = Current.user.borrowings.current.includes(:book)
  end

  def create
    @book = Book.find(params[:book_id])
    @borrowing = Current.user.borrowings.build(book: @book)

    if @borrowing.save
      redirect_to book_path(@book), notice: "Book was successfully borrowed."
    else
      redirect_to book_path(@book), alert: @borrowing.errors.full_messages.to_sentence
    end
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