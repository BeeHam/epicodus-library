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
  # define_method(:books) do
  #   returned_books = DB.exec("SELECT * FROM books WHERE id = #{@id};")
  #   books = []
  #
  #   returned_books.each() do |book|
  #     title =     book.fetch('title')
  #     pub_date =  book.fetch('pub_date')
  #     author =    book.fetch('author')
  #     id =        book.fetch('id').to_i()
  #
  #     books.push(Book.new({:id => id, :author => author, :pub_date => pub_date, :title => title }))
  #   end
  #   books
  # end

  define_method(:books) do
    reader_books = []
    results = DB.exec("SELECT book_id FROM readers_books WHERE reader_id = #{self.id()};")
    results.each() do |result|
      book_id = result.fetch("book_id").to_i()
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = book.first().fetch("title")
      author = book.first().fetch("author")
      pub_date = book.first().fetch("pub_date")
      reader_books.push(Book.new(:title => title, :author => author, :pub_date => pub_date, :id => book_id))
    end
    reader_books
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE readers SET name = '#{@name}' WHERE id = #{@id};")

    attributes.fetch(:book_id, []).each() do |act_id|
      DB.exec("INSERT INTO readers_books (reader_id, book_id) VALUES (#{self.id}, #{act_id});")

    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM readers WHERE id = #{self.id};")

  end
end
