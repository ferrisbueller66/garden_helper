require 'rails_helper'

describe User do
	let(:user) {
		User.create(
			:first_name => "Trevor",
			:last_name => "Tarpinian",
			:username => "trevor",
			:email => "trevor@trevor.com",
			:password => "trevor"
		)
	}
  
  let(:bed1) {
    Bed.create(
      :name => "A629",
      :medium => "Soil"
    )
	}
	
	let(:bed2) {
    Bed.create(
      :name => "B282",
      :medium => "Hydroponic"
    )
  }
  
	it "is valid with first and last name, username, email, and password" do
		expect(user).to be_valid
	end

	it "is not valid without a password" do
		expect(User.new(first_name: "Trevor")).not_to be_valid
	end

	  it "has many plants" do
    first_plant = Plant.create(:user_id => user.id, :bed_id => bed1.id, :variety => "Tomato",)
    second_plant = Plant.create(:user_id => user.id, :bed_id => bed2.id, :variety => "Thai Basil",)
    expect(user.plants.first).to eq(first_plant)
    expect(user.plants.last).to eq(second_plant)
  end

  # it "has many beds through plants" do
  #   user.beds << [bed1, bed2]
  #   expect(user.beds.first).to eq(bed1)
  #   expect(user.bess.last).to eq(bed2)
  # end

#   it "has a method 'mood' that returns 'sad' when the user is more nauseous than happy" do
#     expect(user.mood).to eq("sad")
#   end

#   it "has a method 'mood' that returns 'happy' when the user is more happy than nauseous" do
#     user.update(:happiness => 7)
#     expect(user.mood).to eq("happy")
#   end

end