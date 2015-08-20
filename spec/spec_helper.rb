require('rspec')
require('books')
require('pg')
require('pry')
require('readers')
require('launchy')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM readers *;")
    DB.exec("DELETE FROM readers_books *;")
  end
end
