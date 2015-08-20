require('spec_helper')

describe(Book) do
  describe('.all') do
    it('shows an empty array of books') do
    # Book.clear()
    expect(Book.all).to eq []
    end
  end

  describe('#save') do
    it('adds books to the array of saved books') do
      test_book = Book.new({:title => "Cat in the Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01"})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe('#==') do
    it('is the same book if it is the same name') do
      test_book1 = Book.new({:id => nil, :title => "Cat in the Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01"})
      test_book2 = Book.new({:id => nil, :title => "Cat in the Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01"})
      expect(test_book1).to eq test_book2
    end
  end

  describe('.clear') do
    it('empties out all of the saved books') do
      Book.new({:id => nil, :title => "Cat in the Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01"})
      Book.clear()
      expect(Book.all()).to(eq([]))
    end
  end
  describe('#id') do
    it('lets you read the book id out') do
      test_book = Book.new({:id => nil, :title => "Cat in the Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01"})
      test_book.save()
      expect(test_book.id()).to be_an_instance_of Fixnum
    end
  end

  describe('#update') do
    it('lets you update books in the database') do
      book = Book.new({:id => nil, :title => "Cat in the Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01"})
      book.save()
      reader1 = Reader.new({:name => 'Not Sure', :id => nil})
      reader1.save()
      reader2 = Reader.new({:name => 'Dr. Lexus', :id => nil})
      reader2.save()
      book.update({:reader_id => [reader1.id, reader2.id]})
      expect(book.readers()).to(eq([reader1, reader2]))
    end
  end

  describe('#delete') do
    it('deletes a book from the database.') do
      test_book1 = Book.new({:id => nil, :title => "A Dance of Dragons", :author => "George R.R. Martin", :pub_date => '2007-01-31'})
      test_book1.save
      test_book2 = Book.new({:id => nil, :title => "A Feast for Crows", :author => "George R.R. Martin", :pub_date => '2006-01-31'})
      test_book2.save
      test_book2.delete
      expect(Book.all).to eq [test_book1]
    end
  end

  describe('.find') do
    it('finds the reader by id') do
      test_book = Book.new({:id => nil, :title => "A Dance of Dragons", :author => "George R.R. Martin", :pub_date => '2007-01-31'})
      test_book.save()
      test_book2 = Book.new({:id => nil, :title => "A Feast for Crows", :author => "George R.R. Martin", :pub_date => '2006-01-31'})
      test_book2.save()
      expect(Book.find(test_book.id())).to(eq(test_book))
    end
  end
end
