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

      @shelter_3 = Shelter.create({
        name:    "The Feline Fix",
        address:  "6075 Parkway Drive",
        city:     "Denver",
        state:    "CO",
        zip:      "80022"})
      @pet_1 = Pet.create(
        image: "http://cdn.akc.org/content/hero/cute_puppies_hero.jpg",
        name:  "Louis",
        description: "A very cute floof",
        approximate_age: 2,
        sex: "Male",
        adoption_status: "Pending",
        shelter_id: @shelter_1.id)
      @pet_2 = Pet.create(
        image: "http://cdn.akc.org/content/article-body-image/wirehaired_pointing_griffon_cute_puppies.jpg",
        name:  "Charlie",
        description: "A very handsome floof",
        approximate_age: 5,
        sex: "Male",
        adoption_status: "Approved",
        shelter_id: @shelter_3.id)

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
      @application_2 = Application.create!({
        user_id: "#{@user_1.id}",
        name: "#{@user_1.name}",
        application_status: 'Approved',
        description: 'testtest'
        })

      @review_1 = Review.create({
        title: "Best Place Ever",
        rating: 5,
        content: "The vets were nice af",
        optional_image: "https://sayingimages.com/wp-content/uploads/You-Got-It-meme.jpg",
        reviewer_name: "#{@user_1.name}",
        user_id: "#{@user_1.id}",
        shelter_id: "#{@shelter_2.id}"})
      @review_2 = Review.create!({
        title: "Worst Place Ever",
        rating: 1,
        content: "The vets were stupid af af",
        optional_image: "https://sayingimages.com/wp-content/uploads/You-Got-It-meme.jpg",
        reviewer_name: "#{@user_1.name}",
        user_id: "#{@user_1.id}",
        shelter_id: "#{@shelter_1.id}"})

      PetApplication.create!({pet_id: @pet_1.id, application_id: @application_1.id})
      PetApplication.create!({pet_id: @pet_2.id, application_id: @application_2.id})
    end
    it "The visitor can delete a shelter" do

      visit "/shelters/#{@shelter_2.id}"
      click_on "Delete Shelter"

      expect(page).to_not have_content("The Dumb Friends League")
    end

    it "The visitor cannot delete a shelter if a pet's adoption status is pending" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to_not have_button("Delete Shelter")
    end

    it "The visitor cannot delete a shelter if it has approved applications" do
      visit "/shelters/#{@shelter_3.id}"

      expect(page).to_not have_button("Delete Shelter")
    end

    it "The visitor can delete a shelter and its reviews" do
      visit "/shelters/#{@shelter_2.id}"
      click_on "Delete Shelter"

      visit "/users/#{@user_1.id}"
      expect(page).to_not have_content("#{@review_1.title}")
      expect(page).to have_content("#{@review_2.title}")
    end
  end
end
