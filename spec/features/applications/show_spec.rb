require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /applications/id' do
    before :each do

    @shelter_1 = Shelter.create!({
        name:    "The Feline Fix",
        address:  "6075 Parkway Drive",
        city:     "Denver",
        state:    "CO",
        zip:      "80022"})
    @shelter_2 = Shelter.create!({
          name:    "The Dumb Friends League",
          address:  "2080 S Quebec Street",
          city:     "Denver",
          state:    "CO",
          zip:      "80231"})
    @user_1 = User.create!(
        name:     "Mike Dao",
        address:  "123 Taylor Swift Ave",
        city:     "Denver",
        state:    "CO",
        zip:      "80213")
    @review_1 = Review.create!({
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
    @review_3 = Review.create!({
      title: "Medicore Place Ever",
      rating: 2,
      content: "The vets were stupid af af",
      optional_image: "https://sayingimages.com/wp-content/uploads/You-Got-It-meme.jpg",
      reviewer_name: "#{@user_1.name}",
      user_id: "#{@user_1.id}",
      shelter_id: "#{@shelter_1.id}"})
    @pet_1 = Pet.create!(
      image: "http://cdn.akc.org/content/hero/cute_puppies_hero.jpg",
      name:  "Louis",
      approximate_age: 2,
      sex: "Male",
      shelter_id: "#{@shelter_1.id}")
    @pet_2 = Pet.create!(
      image: "http://cdn.akc.org/content/article-body-image/wirehaired_pointing_griffon_cute_puppies.jpg",
      name:  "Charlie",
      approximate_age: 5,
      sex: "Male",
      shelter_id: "#{@shelter_1.id}")

    @application = Application.create!({
      user_id: "#{@user_1.id}",
      name: "#{@user_1.name}",
      description: "I love animals and I want one",
      application_status: "Pending"
      })

    PetApplication.create!(application: @application, pet: @pet_1)
    PetApplication.create!(application: @application, pet: @pet_2)
    end
    it "The visitor can see the application details" do
      visit "/applications/#{@application.id}"

      expect(page).to have_content("#{@user_1.name}")
      expect(page).to have_content("#{@user_1.address}")
      expect(page).to have_content("#{@user_1.city}")
      expect(page).to have_content("#{@user_1.state}")
      expect(page).to have_content("#{@user_1.zip}")

      expect(page).to have_content("#{@application.description}")
      expect(page).to have_link("#{@pet_1.name}")
      expect(page).to have_link("#{@pet_2.name}")

      expect(page).to have_content("#{@application.application_status}")

    end
  end
end

  # User Story 15, Application Show Page
  #
  # PAIR STORY: It is recommended that you work on this story as a pair. Both partners should understand the data model for applications and how they relate to other models.
  #
  # As a visitor
  # When I visit an applications show page "/applications/:id"
  # Then I can see the following:
  # - Name of the User on the Application
  # - Full Address of the User on the Application
  # - Description of why the applicant says they'd be a good home for this pet(s)
  # - names of all pets that this application is for (all names of pets should be links to their show page)
  # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
