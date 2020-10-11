require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:shelter_id/pets' do
    it "The visitor sees all adoptable pets from shelter with given shelter_id and pet info" do

      shelter_1 = Shelter.create(
          name:     "The Dumb Friends League",
          address:  "2080 S Quebec Street",
          city:     "Denver",
          state:    "CO",
          zip:      "80231")
      pet_1 = Pet.create(
          image: "http://cdn.akc.org/content/hero/cute_puppies_hero.jpg",
          name:  "Louis",
          approximate_age: 2,
          sex: "Male",
          shelter_id: shelter_1.id)
      pet_2 = Pet.create(
          image: "http://cdn.akc.org/content/article-body-image/wirehaired_pointing_griffon_cute_puppies.jpg",
          name:  "Charlie",
          approximate_age: 5,
          sex: "Male",
          shelter_id: shelter_1.id)

      visit "/shelters/#{shelter_1.id}/pets"

      expect(page).to have_xpath("//img[contains(@src, '#{pet_1.image}')]")
      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_1.approximate_age}")
      expect(page).to have_content("#{pet_1.sex}")
      expect(page).to have_content("#{pet_1.shelter_id}")

      expect(page).to have_xpath("//img[contains(@src, '#{pet_2.image}')]")
      expect(page).to have_content("#{pet_2.name}")
      expect(page).to have_content("#{pet_2.approximate_age}")
      expect(page).to have_content("#{pet_2.sex}")
      expect(page).to have_content("#{pet_2.shelter_id}")
    end
  end
end
