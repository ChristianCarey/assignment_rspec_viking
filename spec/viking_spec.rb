describe Viking do 

  let(:viking){ Viking.new }
  let(:bow){ double("Bow", is_a?: true ) }
  before do 
    allow(viking).to receive(:puts)
  end

  it "has a name when you pass it a name" do 
    expect(Viking.new("Bob").name).to eq("Bob")
  end

  it "has health when you pass it health" do 
    expect(Viking.new("larry", 50).health).to eq(50)
  end

  it "does not allow you to change health directly" do 
    expect{viking.health = 20}.to raise_error(NoMethodError)
  end

  it "begins without a weapon" do 
    expect(viking.weapon).to be_nil
  end

  describe "#pick_up_weapon" do 
    
    let(:axe){ double("Axe", is_a?: true, klass: Axe )}
    let(:non_weapon){ double( is_a?: false )}

    it "can pick up a weapon" do 
      viking.pick_up_weapon(bow)
      expect(viking.weapon).to eq(bow)
    end

    it 'can\'t pick up a non-weapon' do
      expect{viking.pick_up_weapon(non_weapon)}.to raise_error("Can't pick up that thing")
    end

    it 'replaces weapon when it picks a new weapon up' do
      viking = Viking.new("Randy", 80, 5, bow)
      viking.pick_up_weapon(axe)
      expect(viking.weapon.klass).to eq(Axe)
    end

  end

  describe '#drop_weapon' do

    it 'drops the weapon' do
      viking.pick_up_weapon(bow)
      viking.drop_weapon
      expect(viking.weapon).to be_nil
    end

  end

  describe '#receive_attack' do

    it 'reduces the viking\'s health by the damage dealt' do
      allow(viking).to receive(:puts)
      expect{viking.receive_attack(10)}.to change{viking.health}.by(-10)
    end

    it 'should call the take_damage method' do
      expect(viking).to receive(:take_damage)
      viking.receive_attack(20)
    end

  end

  describe "#attack" do 

    let(:target){ double("Target", name: "Target", receive_attack: nil )}
    
    it "should attack its target" do 
      allow(viking).to receive(:puts)
      expect(target).to receive(:receive_attack).with(2.5)
      viking.attack(target)
    end
  end
end