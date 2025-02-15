class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :borrowings, dependent: :destroy
  has_many :borrowed_books, through: :borrowings, source: :book

  normalizes :email_address, with: ->(email) { email.strip.downcase }

  validates :email_address, presence: true, 
                          uniqueness: true, 
                          format: { with: URI::MailTo::EMAIL_REGEXP }

  def currently_borrowed_books
    borrowed_books.joins(:borrowings)
                 .where(borrowings: { returned_at: nil })
  end

  def can_borrow_more?
    borrowings.current.count < Borrowing::MAX_BOOKS_PER_USER
  end

  def active_borrowings_count
    borrowings.current.count
  end
end