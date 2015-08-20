class Reader
  attr_reader(:id, :name)
  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes[:id]
    end
  define_singleton_method(:all) do
    returned_readers = DB.exec('SELECT * from readers;')
    readers = []

    returned_readers.each() do |reader|
      name = reader.fetch('name')
      id = reader.fetch('id').to_i()
      readers.push(Reader.new({:id => id, :name => name}))
    end
    readers
  end

  define_method(:==) do |another_reader|
    self.name().==(another_reader.name()).&(self.id().==(another_reader.id()))
  end
  define_method(:save) do
    if ! @id
      @id = "NULL"
    end

    result = DB.exec("INSERT INTO readers (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM readers *;")
  end

  define_singleton_method(:find) do |ident|
    found_reader = nil
    Reader.all().each() do |reader|
      if reader.id().==(ident)
        found_reader = reader
      end
    end
    found_reader
  end
  define_method(:books) do
    returned_books = DB.exec("SELECT * FROM books WHERE book_id = #{@id};")
    books = []

    returned_books.each() do |book|
      title =     book.fetch('title')
      pub_date =  book.fetch('pub_date')
      author =    book.fetch('author')
      book_id =   book.fetch('book_id').to_i()
      id =        book.fetch('id').to_i()

      books.push(Book.new({:id => id, :book_id => book_id, :author => author, :pub_date => pub_date, :title => title }))
    end
    books
  end
end
