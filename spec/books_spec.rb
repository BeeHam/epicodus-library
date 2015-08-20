require('spec_helper')

describe(Book) do
  describe('.all') do
    it('shows an empty array of books') do
    expect(Book.all).to eq []
    end
  end

  describe('#save') do
    it('adds books to the array of saved books') do
      test_book = Book.new({:title => "Cat in the Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01", :book_id => 1})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe('#==') do
    it('is the same book if it is the same name') do
      test_book1 = Book.new({:id => nil, :title => "Cat in the Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01", :book_id => 1})
      test_book2 = Book.new({:id => nil, :title => "Cat in the Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01", :book_id => 1})
      expect(test_book1).to eq test_book2
    end
  end

  describe('.clear') do
    it('empties out all of the saved books') do
      Book.new({:id => nil, :title => "Cat in the Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01", :book_id => 1})
      Book.clear()
      expect(Book.all()).to(eq([]))
    end
  end
  describe('#id') do
    it('lets you read the book id out') do
      test_book = Book.new({:id => nil, :title => "Cat in the Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01", :book_id => 1})
      test_book.save()
      expect(test_book.id()).to be_an_instance_of Fixnum
    end
  end

  describe('#book_id') do
    it('will read the book id out') do
      test_book =Book.new({:id => nil, :title => "Cat in the Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01", :book_id => 1})
      expect(test_book.book_id()).to(eq(1))
    end
  end

  describe('#update') do
    it('lets you update books in the database') do
      book = Book.new({:id => nil, :title => "Cat in the Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01", :book_id => 1})
      book.save()
      book.update({:title => "Cat in Da Hat", :author => "Dr. Seuss", :pub_date => "1942-01-01", :book_id => 1})
      expect(book.title()).to(eq("Cat in Da Hat"))
    end
  end

  describe('#delete') do
    it('deletes a book from the database.') do
      test_book1 = Book.new({:id => nil, :title => "A Dance of Dragons", :author => "George R.R. Martin", :pub_date => '2007-01-31', :book_id => 1})
      test_book1.save
      test_book2 = Book.new({:id => nil, :title => "A Feast for Crows", :author => "George R.R. Martin", :pub_date => '2006-01-31', :book_id => 1})
      test_book2.save
      test_book2.delete
      expect(Book.all).to eq [test_book1]
    end
  end

  describe('.find') do
    it('finds the reader by id') do
      test_book = Book.new({:id => nil, :title => "A Dance of Dragons", :author => "George R.R. Martin", :pub_date => '2007-01-31', :book_id => 1})
      test_book.save()
      test_book2 = Book.new({:id => nil, :title => "A Feast for Crows", :author => "George R.R. Martin", :pub_date => '2006-01-31', :book_id => 1})
      test_book2.save()
      expect(Book.find(test_book.id())).to(eq(test_book))
    end
  end
end
