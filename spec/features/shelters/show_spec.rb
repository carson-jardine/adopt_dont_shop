require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:id' do
    before :each do
      @shelter_1 = Shelter.create({
        name:    "The Feline Fix",
        address:  "6075 Parkway Drive",
        city:     "Denver",
        state:    "CO",
        zip:      "80022"})
      @shelter_2 = Shelter.create({
          name:    "The Dumb Friends League",
          address:  "2080 S Quebec Street",
          city:     "Denver",
          state:    "CO",
          zip:      "80231"})
      @user_1 = User.create({
        name:     "Mike Dao",
        address:  "123 Taylor Swift Ave",
        city:     "Denver",
        state:    "CO",
        zip:      "80213"})
      @user_2 = User.create!(
          name:     "Ace Ventura",
          address:  "323 Banana Ave",
          city:     "Denver",
          state:    "CO",
          zip:      "80213")
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
        shelter_id: "#{@shelter_2.id}"})

      @pet_1 = Pet.create(
        image: "http://cdn.akc.org/content/hero/cute_puppies_hero.jpg",
        name:  "Louis",
        description: "A very cute floof",
        approximate_age: 2,
        sex: "Male",
        adoption_status: "Adoptable",
        shelter_id: @shelter_1.id)
      @pet_2 = Pet.create(
        image: "http://cdn.akc.org/content/article-body-image/wirehaired_pointing_griffon_cute_puppies.jpg",
        name:  "Charlie",
        description: "A very handsome floof",
        approximate_age: 5,
        sex: "Male",
        adoption_status: "Adoptable",
        shelter_id: @shelter_1.id)
      @pet_3 = Pet.create!(
        image: "http://cdn.akc.org/content/article-body-image/wirehaired_pointing_griffon_cute_puppies.jpg",
        name:  "Carrot",
        approximate_age: 5,
        sex: "Male",
        adoption_status: "Adoptable",
        shelter_id: "#{@shelter_2.id}")

      @application_1 = Application.create!({
        user_id: "#{@user_1.id}",
        name: "#{@user_1.name}",
        application_status: 'Pending',
        description: 'testtest'
        })
      @application_2 = Application.create!({
        user_id: "#{@user_2.id}",
        name: "#{@user_2.name}",
        application_status: 'Pending',
        description: 'testtest'
        })
      PetApplication.create!({pet_id: @pet_3.id, application_id: @application_1.id})
      PetApplication.create!({pet_id: @pet_3.id, application_id: @application_2.id})
    end
    it "the visitor sees the shelter with that id and its name, address, city, state, and zip" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content("#{@shelter_1.name}")
      expect(page).to have_content("#{@shelter_1.address}")
      expect(page).to have_content("#{@shelter_1.city}")
      expect(page).to have_content("#{@shelter_1.state}")
      expect(page).to have_content("#{@shelter_1.zip}")

      visit "/shelters/#{@shelter_2.id}"

      expect(page).to have_content("#{@shelter_2.name}")
      expect(page).to have_content("#{@shelter_2.address}")
      expect(page).to have_content("#{@shelter_2.city}")
      expect(page).to have_content("#{@shelter_2.state}")
      expect(page).to have_content("#{@shelter_2.zip}")
    end

    it "User can see a list of reviews for given shelter" do
      visit "/shelters/#{@shelter_2.id}"


      expect(page).to have_content("#{@review_1.title}")
      expect(page).to have_content("#{@review_1.rating}")
      expect(page).to have_content("#{@review_1.content}")
      expect(page).to have_xpath("//img[@src='#{@review_1.optional_image}']")
      expect(page).to have_content("#{@review_1.reviewer_name}")

      end

    it "User sees shelter statistics" do
      visit "/shelters/#{@shelter_2.id}"
      within (".shelter-info") do
        expect(page).to have_content("Total Pets: #{@shelter_2.pet_count}")
        expect(page).to have_content("Average Rating: #{@shelter_2.average_shelter_rating.round(2)}")
        expect(page).to have_content("Number of Applications on File: #{@shelter_2.total_applications}")
      end
    end
    end
  end
