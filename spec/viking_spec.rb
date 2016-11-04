describe Viking do 

  let(:viking){ Viking.new }
  let(:bow){ double("Bow", is_a?: true, use: 2 ) }

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

    it 'raises an error when the viking dies' do
      expect{viking.receive_attack(100)}.to raise_error("RandomViking has Died...")
    end

  end

  describe "#attack" do 

    let(:target){ double("Target", name: "Target", receive_attack: nil )}

    before do
      allow_any_instance_of(Fists).to receive(:use).and_return(1)
    end

    it "should attack its target" do 
      expect(target).to receive(:receive_attack).with(viking.strength)
      viking.attack(target)
    end

    it "damages with fists if the viking has no weapon" do
      expect(viking).to receive(:damage_with_fists)
      viking.attack(target) 
    end

    it "multiplies strength by fist's multiplier when attacking" do
      expect(viking).to receive(:damage_with_fists).and_return(viking.strength)
      viking.attack(target)
    end

    it "damages with weapons if the viking has a weapon" do
      viking.pick_up_weapon(bow)
      expect(viking).to receive(:damage_with_weapon)
      viking.attack(target)
    end

    it "multiplies strength by the weapon's multiplier" do
      viking.pick_up_weapon(bow)
      expect(viking).to receive(:damage_with_weapon).and_return(viking.strength * bow.use)
      viking.attack(target)
    end

    it "it uses fists when bow is out of arrows" do
      allow(bow).to receive(:use).and_raise("Out of arrows")
      viking.pick_up_weapon(bow)
      expect(viking).to receive(:damage_with_fists)
      viking.attack(target)
    end

  end

end