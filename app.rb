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
