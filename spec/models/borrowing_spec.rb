require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  describe "validations" do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    it "sets due_date automatically if not provided" do
      borrowing = build(:borrowing, due_date: nil)
      borrowing.valid?
      expect(borrowing.due_date).to be_present
      expect(borrowing.due_date).to be_within(1.second).of(2.weeks.from_now)
    end

    describe "book availability validation" do
      let(:other_user) { create(:user) }

      it "allows borrowing an available book" do
        borrowing = build(:borrowing, book: book, user: user)
        expect(borrowing).to be_valid
      end

      it "prevents borrowing an already borrowed book" do
        create(:borrowing, book: book, user: other_user)
        borrowing = build(:borrowing, book: book, user: user)
        expect(borrowing).not_to be_valid
        expect(borrowing.errors[:book]).to include("is not available")
      end

      it "allows borrowing a book that was previously borrowed but returned" do
        create(:borrowing, book: book, user: other_user, returned_at: Time.current)
        borrowing = build(:borrowing, book: book, user: user)
        expect(borrowing).to be_valid
      end
    end
  end

  describe "scopes" do
    let(:user) { create(:user) }
    let(:book1) { create(:book) }
    let(:book2) { create(:book) }
    let(:book3) { create(:book) }

    # Current borrowing with future due date
    let!(:current_borrowing) { 
      create(:borrowing, user: user, book: book1, due_date: 1.week.from_now) 
    }

    # Returned borrowing
    let!(:returned_borrowing) { 
      borrowing = create(:borrowing, user: user, book: book2)
      borrowing.update!(returned_at: Time.current)
      borrowing
    }

    # Overdue borrowing
    let!(:overdue_borrowing) { 
      create(:borrowing, user: user, book: book3, due_date: 2.days.ago) 
    }

    describe ".current" do
      it "returns only non-returned borrowings" do
        expect(Borrowing.current).to include(current_borrowing, overdue_borrowing)
        expect(Borrowing.current).not_to include(returned_borrowing)
      end
    end

    describe ".overdue" do
      it "returns only overdue borrowings" do
        expect(Borrowing.overdue).to include(overdue_borrowing)
        expect(Borrowing.overdue).not_to include(current_borrowing, returned_borrowing)
      end
    end
  end

  describe "#overdue?" do
    let(:borrowing) { build(:borrowing) }

    it "returns true when not returned and past due date" do
      borrowing.due_date = 1.day.ago
      expect(borrowing).to be_overdue
    end

    it "returns false when not returned but not past due date" do
      borrowing.due_date = 1.day.from_now
      expect(borrowing).not_to be_overdue
    end

    it "returns false when returned and past due date" do
      borrowing.due_date = 1.day.ago
      borrowing.returned_at = Time.current
      expect(borrowing).not_to be_overdue
    end
  end
end

