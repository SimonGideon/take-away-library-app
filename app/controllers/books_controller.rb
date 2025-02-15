class BooksController < ApplicationController
    allow_unauthenticated_access only: %i[ index]
    before_action :set_book, only: [:show, :borrow]
    before_action :authenticate!, except: [:index, :show]
  
    def index
      @books = Book.all.order(:title)
    end
  
    def show
    end
  
    def new
      @book = Book.new
    end
  
    def create
      @book = Book.new(book_params)
  
      if @book.save
        redirect_to @book, notice: "Book was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def borrow
      borrowing = Current.user.borrowings.build(book: @book)
  
      if borrowing.save
        redirect_to @book, notice: "Book was successfully borrowed."
      else
        redirect_to @book, alert: borrowing.errors.full_messages.to_sentence
      end
    end
  
    private
  
    def set_book
      @book = Book.find(params[:id])
    end
  
    def book_params
      params.require(:book).permit(:title, :author, :isbn)
    end
  end