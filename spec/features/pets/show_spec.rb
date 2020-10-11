require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /pets/:id' do
    it "The visitor sees the pet with matching id and its details" do
      shelter_1 = Shelter.create(
          name:     "The Dumb Friends League",
          address:  "2080 S Quebec Street",
          city:     "Denver",
          state:    "CO",
          zip:      "80231")
      pet_1 = Pet.create(
          image: "http://cdn.akc.org/content/hero/cute_puppies_hero.jpg",
          name:  "Louis",
          description: "A very cute floof",
          approximate_age: 2,
          sex: "Male",
          adoption_status: "Pending",
          shelter_id: shelter_1.id)
      pet_2 = Pet.create(
          image: "http://cdn.akc.org/content/article-body-image/wirehaired_pointing_griffon_cute_puppies.jpg",
          name:  "Charlie",
          description: "A very handsome floof",
          approximate_age: 5,
          sex: "Male",
          adoption_status: "Available",
          shelter_id: shelter_1.id)

      visit "/pets/#{pet_1.id}"

      expect(page).to have_xpath("//img[contains(@src, '#{pet_1.image}')]")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.description)
      expect(page).to have_content(pet_1.approximate_age)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_content(pet_1.adoption_status)
      expect(page).to have_link(pet_1.shelter.name)
    end
  end

end

# User Story 9, Pet Show

# As a visitor
# When I visit '/pets/:id'
# Then I see the pet with that id including the pet's:
# - image
# - name
# - description
# - approximate age
# - sex
# - adoptable/pending adoption status
