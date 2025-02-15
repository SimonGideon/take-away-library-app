require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:isbn) }
    it { should validate_uniqueness_of(:isbn) }

    describe "isbn format" do
      it "allows valid ISBN formats" do
        book = Book.new(
          title: "Test Book",
          author: "Test Author",
          isbn: "978-0-123-45678-9"
        )
        book.valid?
        expect(book.errors[:isbn]).to be_empty
      end

      it "rejects invalid ISBN formats" do
        book = Book.new(
          title: "Test Book",
          author: "Test Author",
          isbn: "invalid-isbn"
        )
        book.valid?
        expect(book.errors[:isbn]).to include("must be a valid ISBN format")
      end
    end

    describe "cover_url format" do
      it "allows valid URLs" do
        book = Book.new(
          title: "Test Book",
          author: "Test Author",
          isbn: "978-0-123-45678-9",
          cover_url: "https://example.com/image.jpg"
        )
        book.valid?
        expect(book.errors[:cover_url]).to be_empty
      end

      it "allows blank cover_url" do
        book = Book.new(
          title: "Test Book",
          author: "Test Author",
          isbn: "978-0-123-45678-9",
          cover_url: ""
        )
        book.valid?
        expect(book.errors[:cover_url]).to be_empty
      end

      it "rejects invalid URLs" do
        book = Book.new(
          title: "Test Book",
          author: "Test Author",
          isbn: "978-0-123-45678-9",
          cover_url: "not-a-url"
        )
        book.valid?
        expect(book.errors[:cover_url]).to include("must be a valid URL starting with http:// or https://")
      end
    end
  end

  describe "associations" do
    it { should have_many(:borrowings).dependent(:destroy) }
    it { should have_many(:borrowers).through(:borrowings) }
  end

  describe "#available?" do
    let(:book) { create(:book) }
    let(:user) { create(:user) }

    it "returns true when book has no current borrowings" do
      expect(book).to be_available
    end

    it "returns false when book is currently borrowed" do
      create(:borrowing, book: book, user: user)
      expect(book).not_to be_available
    end

    it "returns true when book has only returned borrowings" do
      create(:borrowing, book: book, user: user, returned_at: Time.current)
      expect(book).to be_available
    end
  end

  describe "#current_borrowing" do
    let(:book) { create(:book) }
    let(:user) { create(:user) }

    it "returns nil when book has no borrowings" do
      expect(book.current_borrowing).to be_nil
    end

    it "returns the current borrowing when book is borrowed" do
      borrowing = create(:borrowing, book: book, user: user)
      expect(book.current_borrowing).to eq(borrowing)
    end

    it "returns nil when book has only returned borrowings" do
      create(:borrowing, book: book, user: user, returned_at: Time.current)
      expect(book.current_borrowing).to be_nil
    end
  end

  describe "#current_borrower" do
    let(:book) { create(:book) }
    let(:user) { create(:user) }

    it "returns nil when book has no borrowings" do
      expect(book.current_borrower).to be_nil
    end

    it "returns the current borrower when book is borrowed" do
      create(:borrowing, book: book, user: user)
      expect(book.current_borrower).to eq(user)
    end

    it "returns nil when book has only returned borrowings" do
      create(:borrowing, book: book, user: user, returned_at: Time.current)
      expect(book.current_borrower).to be_nil
    end
  end
end