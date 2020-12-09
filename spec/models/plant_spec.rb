require 'rails_helper'

describe Plant do
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

	let(:plant3) {
    Plant.create(
			:user_id => user.id,
			:bed_id => bed.id,
			:variety => "Tomato",
			:harvested => true,
			:germination_date=> "2020-12-05"
    )
	}

  context 'Attributes' do
		it "is valid with varietal name and medium attributes" do
			expect(plant).to be_valid
		end

		it "is not valid without a varietal name" do
			expect(Plant.new).not_to be_valid
		end
	end
	context 'Associations' do

		it "belongs to a User" do
			expect(plant.user).to eq(user)
		end

		it "belongs to a Bed" do
			expect(plant.bed).to eq(bed)
		end
		
		it "has many harvests" do
			first_harvest = Harvest.create(:weight => "1.2", :harvest_date => 20201201, :plant_id => plant.id)
			second_harvest = Harvest.create(:weight => "2.0", :harvest_date => 20201201, :plant_id => plant.id)
			expect(plant.harvests.first).to eq(first_harvest)
			expect(plant.harvests.last).to eq(second_harvest)
		end
	end
	
	context 'Scopes' do

		it "utilizes scope for sorting plants by varietal name" do
			Plant.all.sorted_by_name == [plant2, plant, plant3]
		end

		it "utilizes scope for sorting plants by varietal germination date" do
			Plant.all.sorted_by_germination_date == [plant2, plant3, plant]
		end

		it "utilizes scope that filters all plants with a harvest" do
			harvested_plants = Plant.all.been_harvested
			expect(harvested_plants).to include(plant, plant3)
		end
	end
end