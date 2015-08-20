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
      book_id = book.fetch('book_id').to_i()
      title = book.fetch('title')
      author = book.fetch('author')
      pub_date = book.fetch('pub_date')
      books.push(Book.new({:id => id, :title => title, :pub_date => pub_date, :author => author, :book_id => book_id}))
    end
    books
  end

  define_method(:save) do
    if ! @id
      @id = "NULL"
    end
    result = DB.exec("INSERT INTO books (title, pub_date, author, book_id) VALUES ('#{@title}', '#{@pub_date}', '#{@author}', #{@book_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end
  define_method(:==) do |another_book|
    self.title.==(another_book.title).&(self.book_id.==(another_book.book_id)).&(self.id.==(another_book.id)).&(self.pub_date.==(another_book.pub_date)).&(self.author.==(another_book.author))
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM books *;")
  end

  define_method(:update) do |attributes|
    @id = self.id()
    # @book_id = attributes.fetch(:book_id).to_i()
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @pub_date = attributes.fetch(:pub_date)
    DB.exec("UPDATE books SET title = '#{@title}', author = '#{@author}', pub_date = '#{@pub_date}' WHERE id = #{@id};")
  end
end
