require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /admin/applications/:id' do
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
      application_status: 'Pending',
      description: 'testtest'
      })

      PetApplication.create!({pet_id: @pet_1.id, application_id: @application.id})
      PetApplication.create!({pet_id: @pet_2.id, application_id: @application.id})

    end
    it "Visitor can click approval button" do
      visit "/admin/applications/#{@application.id}"
      click_on "Reject #{@pet_1.name}"
      click_on "Approve #{@pet_2.name}"
      save_and_open_page
      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to have_content("Approved")
    end
  end
end
