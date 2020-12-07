require 'rails_helper'

describe Bed do
	let(:user) {
		User.create(
			:first_name => "Trevor",
			:last_name => "Tarpinian",
			:username => "trevor",
			:email => "trevor@trevor.com",
			:password => "trevor"
		)
	}
  
  let(:bed) {
    Bed.create(
      :name => "A629",
			:medium => "soil",
			:location => "basement"
    )
	}

	let(:bed2) {
    Bed.create(
      :name => "B239",
			:medium => "aquaponic",
			:location => "basement"
    )
	}

	let(:bed3) {
    Bed.create(
      :name => "C852",
      :medium => "soil"
    )
	}

	let(:bed4) {
    Bed.create(
      :name => "D815",
      :medium => "aquaponic"
    )
	}

	let(:plant_one) {
    Plant.create(
			:user_id => user.id,
			:bed_id => bed.id,
      :variety => "Tomato"
    )
	}

	let(:plant_two) {
    Plant.create(
			:user_id => user.id,
			:bed_id => bed.id,
      :variety => "Cilantro"
    )
	}
  
	it "is valid with name and medium attributes" do
		expect(bed).to be_valid
	end

	it "is not valid without a name" do
		expect(Bed.new).not_to be_valid
	end

	it "has many plants" do
		bed.plants << [plant_one, plant_two]
		expect(bed.plants.first).to eq(plant_one)
		expect(bed.plants.last).to eq(plant_two)
  end

	it "has many users through plants" do
		Plant.create(:user_id => user.id,:bed_id => bed.id, :variety => "Tomato")
    expect(bed.users.first).to eq(user)
	end
	
	it "has many harvests through plants" do
		first_harvest = Harvest.create(:weight => "1.2", :harvest_date => 20201201, :plant_id => plant_one.id)
		second_harvest = Harvest.create(:weight => "2.0", :harvest_date => 20201201, :plant_id => plant_two.id)
    expect(bed.harvests.first).to eq(first_harvest)
    expect(bed.harvests.last).to eq(second_harvest)
  end

	it "utilizes scope by medium type (soil)" do
		soil_beds = Bed.all.medium_soil
    expect(soil_beds).to include(bed, bed3)
  end

	it "utilizes scope by medium type (water)" do
		water_beds = Bed.all.medium_water
    expect(water_beds).to include(bed2, bed4)
  end

	it "utilizes scope by location" do
		basement_beds = Bed.all.location_basement
    expect(basement_beds).to include(bed, bed2)
  end

end