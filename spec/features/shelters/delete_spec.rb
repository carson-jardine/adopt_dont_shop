require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:id' do
    before :each do
      @shelter_1 = Shelter.create(
        name:     "Denver Animal Shelter",
        address:  "1241 W Bayaud Avenue",
        city:     "Denver",
        state:    "CO",
        zip:      "80223")

      @shelter_2 = Shelter.create({
          name:    "The Dumb Friends League",
          address:  "2080 S Quebec Street",
          city:     "Denver",
          state:    "CO",
          zip:      "80231"})
      @pet_1 = Pet.create(
        image: "http://cdn.akc.org/content/hero/cute_puppies_hero.jpg",
        name:  "Louis",
        description: "A very cute floof",
        approximate_age: 2,
        sex: "Male",
        adoption_status: "Adoptable",
        shelter_id: @shelter_1.id)
      @user_1 = User.create({
        name:     "Mike Dao",
        address:  "123 Taylor Swift Ave",
        city:     "Denver",
        state:    "CO",
        zip:      "80213"})
      @application_1 = Application.create!({
        user_id: "#{@user_1.id}",
        name: "#{@user_1.name}",
        application_status: 'Pending',
        description: 'testtest'
        })

      PetApplication.create!({pet_id: @pet_1.id, application_id: @application_1.id})
    end
    it "The visitor can delete a shelter" do

      visit "/shelters/#{@shelter_2.id}"
      click_on "Delete Shelter"

      expect(page).to_not have_content("The Dumb Friends League")
    end

    it "The visitor cannot delete a shelter if a pet's status is pending" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to_not have_button("Delete Shelter")
    end
  end
end
