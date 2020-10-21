require 'rails_helper'

describe Pet do
  describe "relationship" do
    it {should belong_to :shelter}
    it {should have_many :pet_applications}
    it {should have_many(:applications).through(:pet_applications)}
  end

  describe "class methods" do
    it ".search(search)" do
      @shelter_1 = Shelter.create!({
        name:    "The Feline Fix",
        address:  "6075 Parkway Drive",
        city:     "Denver",
        state:    "CO",
        zip:      "80022"})
      @pet_1 = Pet.create!(
        image: "http://cdn.akc.org/content/hero/cute_puppies_hero.jpg",
        name:  "Louis",
        approximate_age: 2,
        sex: "Male",
        shelter_id: "#{@shelter_1.id}")
      expect(Pet.search("Lou")).to eq([@pet_1])
    end
  end
end
