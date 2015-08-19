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
end
