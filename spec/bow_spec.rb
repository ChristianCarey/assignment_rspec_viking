# Your code here

describe Bow do

  let(:bow){ Bow.new }

  it 'has arrows' do
    expect{ bow.arrows }.not_to raise_error
  end

  it 'starts with 10 arrows by default' do
    expect(bow.arrows).to eq(10)
  end

  it 'can start with a specified number of arrows' do
    expect(Bow.new(5).arrows).to eq(5)
  end

  describe '#use' do

    before do 
      allow(bow).to receive(:puts)
    end

    it 'should reduce arrows by 1' do
      expect{bow.use}.to change{bow.arrows}.by(-1)
    end

    it 'should throw and error if out of arrows' do
      expect{Bow.new(0).use}.to raise_error('Out of arrows')
    end

  end


end