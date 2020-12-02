RSpec.describe User, :type => :model do
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
      :medium => "Soil"
    )
  }
  
	let(:plant) {
		Plant.create(
			:variety => "Tomato",
			:user_id => user.id,
			:bed_id => bed.id
		)
	}
  
	it "is valid with first and last name, username, email, and password" do
		expect(user).to be_valid
	end

	it "is not valid without a password" do
		expect(User.new(name: "Trevor")).not_to be_valid
	end

end