require('spec_helper')

describe(Book) do
  describe('.all') do
    it('shows an empty array of books') do
    expect(Book.all).to(eq([]))
    end
  end
end
