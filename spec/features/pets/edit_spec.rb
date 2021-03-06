require 'rails_helper'

describe 'As a visitor' do
  before :each do
    @shelter_1 = Shelter.create(
        name:     "The Dumb Friends League",
        address:  "2080 S Quebec Street",
        city:     "Denver",
        state:    "CO",
        zip:      "80231")
    @pet_1 = Pet.create(
        image: "http://cdn.akc.org/content/hero/cute_puppies_hero.jpg",
        name:  "Louis",
        approximate_age: 2,
        sex: "Male",
        shelter_id: "#{@shelter_1.id}")
    @pet_2 = Pet.create(
        image: "http://cdn.akc.org/content/article-body-image/wirehaired_pointing_griffon_cute_puppies.jpg",
        name:  "Charlie",
        approximate_age: 5,
        sex: "Male",
        shelter_id: "#{@shelter_1.id}")
  end
  describe 'When I visit /pets/:id' do
    it "The visitor can navigate to Update Pet page" do

      visit "/pets/#{@pet_1.id}"
      click_on "Update Pet"

      expect(page).to have_content("Edit Pet Info:")
      expect(page).to have_button("Submit")
    end
  end

  describe 'When I visit /pets/:id/edit' do
    it "The visitor can fill in form to update pet info" do
      visit "/pets/#{@pet_2.id}/edit"

      fill_in :image, with: "http://cdn.akc.org/content/article-body-image/shih_tzu_cute_puppies.jpg"
      fill_in :name, with: "Blueberry"
      fill_in :description, with: "A little tiny baby dog"
      fill_in :approximate_age, with: 1
      fill_in :sex, with: "Female"
      click_on "Submit"

      expect(current_path).to eq("/pets/#{@pet_2.id}")

      pet = Pet.last
      expect(page).to have_xpath("//img[contains(@src,'#{pet.image}')]")
      expect(pet.name).to eq("Blueberry")
      expect(pet.description).to eq("A little tiny baby dog")
      expect(pet.approximate_age).to eq(1)
      expect(pet.sex).to eq("Female")
    end
  end

end
