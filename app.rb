require('sinatra')
require('sinatra/reloader')
require('./lib/books')
require('./lib/readers')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'library_test'})

get('/') do
  erb(:index)
end

# get('/readers/new')
#   erb(:)
# end

get('/readers') do
  @readers = Reader.all()
  erb(:reader_list)
end

post('/readers') do
  name = params.fetch('name')
  reader = Reader.new(:name => name, :id => nil)
  reader.save()
  @readers = Reader.all()
  erb(:reader_list)
end

get('/readers/:id') do
  @reader = Reader.find(params.fetch('id').to_i())
  # @book = Book.find(params.fetch('id').to_i())
  erb(:book_list)
end

post('/readers/:id/books') do
  reader_id = params.fetch('reader_id').to_i()
  @reader = Reader.find(reader_id)
  title = params.fetch('title')
  pub_date = params.fetch('pub_date')
  author = params.fetch('author')
  # book_id = params.fetch("book_id").to_i()
  book = Book.new(:id => nil, :title => title, :pub_date => pub_date, :author => author)
  book.save()
  @books = Book.all()
  erb(:book_list)
end

# get('/readers/:id') do
#   @reader = Reader.find(params.fetch('id').to_i())
#   erb(:book_list)
# end
