FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "Book Title #{n}" }
    sequence(:author) { |n| "Author #{n}" }
    sequence(:isbn) { |n| "978-0-#{n.to_s.rjust(3, '0')}-45678-9" }
    cover_url { "https://example.com/book-cover.jpg" }
  end
end