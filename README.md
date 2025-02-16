# Book Rental Library App

A simple book rental system built with Ruby on Rails 8, where users can browse and borrow books.

## Requirements

- Ruby 3.3.5
- Rails 8.0.1
- PostgreSQL

## Setup

1. Clone the repository
```bash
https://github.com/SimonGideon/library-app.git
cd library-app
```

2. Install dependencies
```bash
bundle install
```

3. Database setup
```bash
# Create and migrate database
rails db:create
rails db:migrate

# Load sample books
rails db:seed
```

4. Start the server
```bash
./bin/dev
```

5. Run Test
   ```
    bundle exec rspec
   ```

Visit `http://localhost:3000` in your browser.

## Features
- User authentication
- Browse available books
- Borrow and return books
- Track borrowed books
- Book availability status
