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

Summary list with the main operations:

```ruby
GET  /messages # list messages
POST /messages { <message json> } # to create a message
GET  /messages/:id 
 
PATCH or PUT /messages/:id(.:format)
DELETE /messages/:id(.:format)
....
```
