# README

Ruby 3.0.2, Rails 6.1.4, and **sqlite3** as database for active record.

## Configuration

* Establish environment with usual `RAILS_ENV` environment variable or will be `development` by default.

* Optionally relocate database as usual with `DATABASE_URL` environment variable or files will be located according to active ralis environment in one of:
  * `📁./db/development.sqlite3`.
  * `📁./db/test.sqlite3`.
  * `📁./db/production.sqlite3`.
  
* Create database executing:
  * `> rails db:create`
  * `> rails db:migrate`

* Run tests by executing:

  `> rails test`
  
* Run the application locally with

  ```bash
  bundle install
  bundle exec rails server -b 0.0.0.0
  ```

## Usage

For demostrative purpose and easing the review, if you browse to the API with a browser you'll be redirected to the public folder api-doc where you can see the list of operations implemented and code samples for execution. Notice the order of operations, you'll need to start by login or signup and login to obtain a token to use with the rest of the operations.
