class Book
  attr_reader(:id, :title, :pub_date, :author, :book_id)
  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @pub_date = attributes.fetch(:pub_date)
    @author = attributes.fetch(:author)
    @book_id = attributes[:book_id]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      id = book.fetch('id').to_i()
      book_id = book.fetch('book_id')
      title = book.fetch('title')
      author = book.fetch('author')
      pub_date = book.fetch('pub_date')
      books.push(Book.new({:id => id, :title => title, :pub_date => pub_date, :author => author, :book_id => book_id}))
    end
    books
  end
end
