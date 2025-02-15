class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :due_date, presence: true
  validate :book_must_be_available, on: :create

  before_validation :set_due_date, on: :create

  scope :current, -> { where(returned_at: nil) }
  scope :overdue, -> { current.where('due_date < ?', Time.current) }

  def overdue?
    !returned_at && due_date < Time.current
  end

  private

  def set_due_date
    self.due_date ||= 2.weeks.from_now
  end

  def book_must_be_available
    if book.present? && !book.available? && !returned_at
      errors.add(:book, "is not available")
    end
  end
end