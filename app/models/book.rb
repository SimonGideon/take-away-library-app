class Book < ApplicationRecord
    has_many :borrowings, dependent: :destroy
    has_many :borrowers, through: :borrowings, source: :user
  
    validates :title, presence: true
    validates :author, presence: true
    validates :isbn, presence: true, 
                    uniqueness: true,
                    format: { with: /\A[0-9-]{10,17}\z/, message: "must be a valid ISBN format" }
    validates :cover_url, format: { 
    with: URI::regexp(%w[http https]),
    message: "must be a valid URL starting with http:// or https://",
    allow_blank: true
  }

  
    def available?
      !borrowings.where(returned_at: nil).exists?
    end
  
    def current_borrowing
      borrowings.where(returned_at: nil).first
    end
  
    def current_borrower
      current_borrowing&.user
    end

    def similar_books(limit: 10)
      Book.where.not(id: self.id)
          .order("RANDOM()")
          .limit(limit)
    end
  end