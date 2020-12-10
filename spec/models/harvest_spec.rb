require 'rails_helper'

describe Harvest do
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

	let(:plant) {
    Plant.create(
			:user_id => user.id,
			:bed_id => bed.id,
			:variety => "Tomato",
			:harvested => true,
			:germination_date=> "2020-12-06"
    )
	}

	let(:plant2) {
    Plant.create(
			:user_id => user.id,
			:bed_id => bed.id,
			:variety => "Cilantro",
			:harvested => false,
			:germination_date=> "2020-12-04"
    )
	}

	let(:harvest1) {
    Harvest.create(
			:plant_id => plant.id,
			:weight => "1.3",
			:harvest_date=> "2020-12-04"
    )
  }
    
	let(:harvest2) {
		Harvest.create(
			:plant_id => plant2.id,
			:weight => "2.8",
			:harvest_date=> "2020-12-05"
		)
	}

  context 'Attributes' do
		it "is valid with weight and medium attributes" do
			expect(harvest1).to be_valid
		end

		it "is not valid without a weight" do
			expect(Harvest.new).not_to be_valid
		end

		it "is not valid without a harvest date" do
			expect(Harvest.new).not_to be_valid
		end
	end

	context 'Associations' do

		it "belongs to a Plant" do
			expect(harvest1.plant).to eq(plant)
			expect(harvest2.plant).to eq(plant2)
		end

		it "belongs to a Bed" do
			expect(harvest1.plant.bed).to eq(bed)
		end
		
		it "belongs to a User" do
			expect(harvest1.plant.user).to eq(user)
		end
	end
	
	# context 'Scopes' do

	# 	it "utilizes scope for sorting plants by varietal name" do
	# 		Plant.all.sorted_by_name == [plant2, plant, plant3]
	# 	end

	# 	it "utilizes scope for sorting plants by varietal germination date" do
	# 		Plant.all.sorted_by_germination_date == [plant2, plant3, plant]
	# 	end

	# 	it "utilizes scope that filters all plants with a harvest" do
	# 		harvested_plants = Plant.all.been_harvested
	# 		expect(harvested_plants).to include(plant, plant3)
	# 	end
	# end
end