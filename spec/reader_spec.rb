require('spec_helper')

describe('Reader') do
  describe('.all') do
    it('displays the empty array') do
    expect(Reader.all).to eq []
    end
  end

  describe('#==') do
    it('is the same reader if they have the same attributes') do
      test_reader1 = Reader.new({:id => nil, :name => "Joey Tribiani"})
      test_reader2 = Reader.new({:id => nil, :name => "Joey Tribiani"})
      expect(test_reader1).to eq test_reader2
    end
  end
  describe('#save') do
    it('saves a reader') do
      test_reader1 = Reader.new({:id => nil, :name => "Chandler Bing"})
      test_reader1.save()
      expect(test_reader1).to eq test_reader1
    end
  end

  describe('.clear') do
    it('empties out all of the saved readers') do
      Reader.new({:id => nil, :name => "Ross Geller"})
      Reader.clear()
      expect(Reader.all()).to(eq([]))
    end
  end
  describe('#id') do
    it('returns the id of the reader') do
    test_reader = Reader.new({:id => nil, :name => 'Phoebe Boffet'})
    test_reader.save()
    expect(test_reader.id).to be_an_instance_of Fixnum
    end
  end

  describe('.find') do
    it('finds the reader by id') do
      test_reader = Reader.new({:name => "Not Sure", :id => nil})
      test_reader.save()
      test_reader2 = Reader.new({:name => "Formica Jones", :id => nil})
      test_reader2.save()
      expect(Reader.find(test_reader.id())).to(eq(test_reader))
    end
  end
  describe('#name') do
  it('returns the name of the reader') do
    test_reader = Reader.new({:name => 'Frito Bandito', :id => nil})
    test_reader.save()
    expect(test_reader.name()).to eq 'Frito Bandito'
  end
  end
end

#still need a #name(?) #books, #add_books, and .find spec in readers.rb
