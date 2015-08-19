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
      @name = reader.fetch('name')
      @id = reader.fetch('id').to_i()
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
end
