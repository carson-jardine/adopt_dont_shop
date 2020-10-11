require 'rails_helper'

describe 'As a visitor' do
  before :each do
    @shelter_1 = Shelter.create(
      name:     "The Dumb Friends League",
      address:  "2080 S Quebec Street",
      city:     "Denver",
      state:    "CO",
      zip:      "80231")
  end

  describe 'When I visit /shelters/shelter_id/pets' do
    it "The visitor can navigate to New Pet approximate_age" do
      visit "/shelters/#{@shelter_1.id}/pets"
      click_link("Create Pet")

      expect(page).to have_content("Enter a New Pet:")
      expect(page).to have_button("Create Pet")
    end
  end

  describe 'When I visit /shelters/shelter_id/pets/new' do
    it "The visitor can fill out a form" do
      visit "/shelters/#{@shelter_1.id}/pets/new"

      fill_in "pet[image]", with: "http://cdn.akc.org/content/hero/cute_puppies_hero.jpg"
      fill_in "pet[name]", with: "Louis"
      fill_in "pet[description]", with: "A very cute floof"
      fill_in "pet[approximate_age]", with: 2
      fill_in "pet[sex]", with: "Male"

      click_button "Create Pet"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
      expect(page).to have_content("Louis")

      pet = Pet.last
      expect(pet.name).to eq("Louis")
      expect(pet.description).to eq("A very cute floof")
      expect(pet.approximate_age).to eq(2)
      expect(pet.sex).to eq("Male")
      expect(pet.adoption_status).to eq("Adopatable")
    end
  end
end
