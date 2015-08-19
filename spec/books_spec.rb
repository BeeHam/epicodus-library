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
end
