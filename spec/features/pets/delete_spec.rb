require 'rails_helper'

describe 'As a visitor' do
  before :each do
    @user_1 = User.create({
      name:     "Mike Dao",
      address:  "123 Taylor Swift Ave",
      city:     "Denver",
      state:    "CO",
      zip:      "80213"})
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
        adoption_status: "Approved",
        shelter_id: "#{@shelter_1.id}")

    @application_1 = Application.create!({
      user_id: "#{@user_1.id}",
      name: "#{@user_1.name}",
      application_status: 'Approved',
      description: 'testtest'
      })

    PetApplication.create!({pet_id: @pet_2.id, application_id: @application_1.id})

  end
  describe 'When I visit /pets/id' do
    it "The visitor can delete a pet" do
      visit "/pets/#{@pet_1.id}"
      click_on "Delete Pet"

      expect(current_path).to eq("/pets")
      expect(page).to_not have_content("Louis")
    end

    it "The visitor cannot delete a pet if it has approved applications" do
      visit "/pets/#{@pet_2.id}"

      expect(page).to_not have_button("Delete Pet")

    end
  end

end
