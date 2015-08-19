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
end
