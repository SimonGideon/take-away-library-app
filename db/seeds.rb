# db/seeds.rb

# Clear existing books
puts "Clearing existing books..."
Book.destroy_all

# List of 20 popular books with their details
books = [
  {
    title: "The Midnight Library",
    author: "Matt Haig",
    isbn: "978-0525559474",
    cover_url: "https://covers.openlibrary.org/b/id/10389354-L.jpg"
  },
  {
    title: "Project Hail Mary",
    author: "Andy Weir",
    isbn: "978-0593135204",
    cover_url: "https://covers.openlibrary.org/b/id/10837111-L.jpg"
  },
  {
    title: "Atomic Habits",
    author: "James Clear",
    isbn: "978-1847941831",
    cover_url: "https://covers.openlibrary.org/b/id/10389354-L.jpg"
  },
  {
    title: "Fourth Wing",
    author: "Rebecca Yarros",
    isbn: "978-1649374042",
    cover_url: "https://covers.openlibrary.org/b/id/12849461-L.jpg"
  },
  {
    title: "Tomorrow, and Tomorrow, and Tomorrow",
    author: "Gabrielle Zevin",
    isbn: "978-0593321201",
    cover_url: "https://covers.openlibrary.org/b/id/12679831-L.jpg"
  },
  {
    title: "Lessons in Chemistry",
    author: "Bonnie Garmus",
    isbn: "978-0385547345",
    cover_url: "https://covers.openlibrary.org/b/id/12721187-L.jpg"
  },
  {
    title: "The Seven Husbands of Evelyn Hugo",
    author: "Taylor Jenkins Reid",
    isbn: "978-1501161933",
    cover_url: "https://covers.openlibrary.org/b/id/12554416-L.jpg"
  },
  {
    title: "Happy Place",
    author: "Emily Henry",
    isbn: "978-0593441275",
    cover_url: "https://covers.openlibrary.org/b/id/13237175-L.jpg"
  },
  {
    title: "Iron Flame",
    author: "Rebecca Yarros",
    isbn: "978-1649374059",
    cover_url: "https://covers.openlibrary.org/b/id/13298211-L.jpg"
  },
  {
    title: "The Creative Act",
    author: "Rick Rubin",
    isbn: "978-0593652886",
    cover_url: "https://covers.openlibrary.org/b/id/13067797-L.jpg"
  },
  {
    title: "The Body Keeps the Score",
    author: "Bessel van der Kolk",
    isbn: "978-0143127741",
    cover_url: "https://covers.openlibrary.org/b/id/13067799-L.jpg"
  },
  {
    title: "House of Sky and Breath",
    author: "Sarah J. Maas",
    isbn: "978-1635574074",
    cover_url: "https://covers.openlibrary.org/b/id/12627722-L.jpg"
  },
  {
    title: "The Psychology of Money",
    author: "Morgan Housel",
    isbn: "978-0857197689",
    cover_url: "https://covers.openlibrary.org/b/id/12547872-L.jpg"
  },
  {
    title: "The Silent Patient",
    author: "Alex Michaelides",
    isbn: "978-1250301697",
    cover_url: "https://covers.openlibrary.org/b/id/8831827-L.jpg"
  },
  {
    title: "Verity",
    author: "Colleen Hoover",
    isbn: "978-1538724736",
    cover_url: "https://covers.openlibrary.org/b/id/12752577-L.jpg"
  },
  {
    title: "The Light We Carry",
    author: "Michelle Obama",
    isbn: "978-0593237465",
    cover_url: "https://covers.openlibrary.org/b/id/12814254-L.jpg"
  },
  {
    title: "Demon Copperhead",
    author: "Barbara Kingsolver",
    isbn: "978-0063251922",
    cover_url: "https://covers.openlibrary.org/b/id/12814255-L.jpg"
  },
  {
    title: "Trust",
    author: "Hernan Diaz",
    isbn: "978-0593420317",
    cover_url: "https://covers.openlibrary.org/b/id/12616996-L.jpg"
  },
  {
    title: "Tomorrow Will Be Different",
    author: "Sarah McBride",
    isbn: "978-1524761479",
    cover_url: "https://covers.openlibrary.org/b/id/12911511-L.jpg"
  },
  {
    title: "The Covenant of Water",
    author: "Abraham Verghese",
    isbn: "978-0802162176",
    cover_url: "https://covers.openlibrary.org/b/id/13298416-L.jpg"
  },
  {
    title: "A Court of Silver Flames",
    author: "Sarah J. Maas",
    isbn: "978-1635577953",
    cover_url: "https://covers.openlibrary.org/b/id/10579581-L.jpg"
},
{
    title: "The It Girl",
    author: "Ruth Ware",
    isbn: "978-1982155261",
    cover_url: "https://covers.openlibrary.org/b/id/12714290-L.jpg"
},
]

# Create books
puts "Creating books..."
books.each do |book_data|
  book = Book.create!(
    title: book_data[:title],
    author: book_data[:author],
    isbn: book_data[:isbn],
    cover_url: book_data[:cover_url]
  )
  puts "Created #{book.title} by #{book.author}"
end

puts "Created #{Book.count} books successfully!"