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

  describe "#calls_some_methods" do 

    let(:string){ instance_double("String", :upcase! => nil, :reverse! => nil, :empty? => nil) }

    it "raises an error if the argument is empty" do 
      allow(string).to receive(:empty?).and_return(true)
      expect{ warmup.calls_some_methods(string) }.to raise_error("Hey, give me a string!")
    end

    it "capitalizes the argument" do 
      expect(string).to receive(:upcase!).and_return(string)
      warmup.calls_some_methods(string)
    end

    it "reverses the argument" do 
      allow(string).to receive(:upcase!).and_return(string)
      expect(string).to receive(:reverse!)
      warmup.calls_some_methods(string)
    end
  end
end
