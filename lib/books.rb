class Book
  attr_reader(:id, :title, :pub_date, :author)
  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @pub_date = attributes.fetch(:pub_date)
    @author = attributes.fetch(:author)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      id = book.fetch('id').to_i()
      title = book.fetch('title')
      author = book.fetch('author')
      pub_date = book.fetch('pub_date')
      books.push(Book.new({:id => id, :title => title, :pub_date => pub_date, :author => author}))
    end
    books
  end

  define_method(:save) do
    if ! @id
      @id = "NULL"
    end
    result = DB.exec("INSERT INTO books (title, pub_date, author) VALUES ('#{@title}', '#{@pub_date}', '#{@author}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end
  define_method(:==) do |another_book|
    self.title.==(another_book.title).&(self.id.==(another_book.id)).&(self.pub_date.==(another_book.pub_date)).&(self.author.==(another_book.author))
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM books *;")
  end

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title, @title)
    @author = attributes.fetch(:author, @author)
    @pub_date = attributes.fetch(:pub_date, @pub_date)

    DB.exec("UPDATE books SET title = '#{@title}', author = '#{@author}', pub_date = '#{@pub_date}' WHERE id = #{@id};")

    attributes.fetch(:reader_id, []).each() do |read_id|
      DB.exec("INSERT INTO readers_books (reader_id, book_id) VALUES (#{read_id}, #{self.id});")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM books WHERE id = #{self.id};")
  end

  define_singleton_method(:find) do |ident|
    found_book = nil
    Book.all().each() do |book|
      if book.id().==(ident)
        found_book = book
      end
    end
    found_book
  end

  define_method(:readers) do
    book_readers = []
    results = DB.exec("SELECT reader_id FROM readers_books WHERE book_id = #{self.id()};")
    results.each() do |result|
      reader_id = result.fetch("reader_id").to_i()
      reader = DB.exec("SELECT * FROM readers WHERE id = #{reader_id};")
      name = reader.first().fetch("name")
      book_readers.push(Reader.new(:name => name, :id => reader_id))
    end
    book_readers
  end
end
