require('spec_helper')

describe('Reader') do
  describe('.all') do
    it('displays the empty array') do
    expect(Reader.all).to eq []
    end
  end
end
