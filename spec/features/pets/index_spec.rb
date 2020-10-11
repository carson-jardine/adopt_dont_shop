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

  describe 'When I visit /pets' do
    it "The visitor sees the details about each pet in system" do

      visit "/pets"

      expect(page).to have_xpath("//img[contains(@src, '#{@pet_1.image}')]")
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_content("#{@pet_1.approximate_age}")
      expect(page).to have_content("#{@pet_1.sex}")
      expect(page).to have_content("#{@pet_1.shelter.name}")
    end
  end
end
