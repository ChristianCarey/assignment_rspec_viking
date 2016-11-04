describe Warmup do

  let(:warmup){ Warmup.new }

  describe '#gets_shout' do

    it 'can convert the input to uppercase' do
      allow(warmup).to receive(:gets).and_return('test')
      expect(warmup.gets_shout).to eq('TEST')
    end

  end

  describe '#triple_size' do

    let(:array){ instance_double('Array', :size => 3)}

    it 'returns the size of an input times 3' do 
      expect(warmup.triple_size(array)).to eq(9)
    end

  end

end
