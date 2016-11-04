describe Viking do 

  let(:viking){ Viking.new }

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
    
    let(:weapon){ double("Weapon", is_a?: true ) }

    it "can pick up a weapon" do 
      viking.pick_up_weapon(weapon)
      expect(viking.weapon).to eq(weapon)
    end
  end
end