require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/shelter_id' do
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

      @review_1 = Review.create({
        title: "Best Place Ever",
        rating: 5,
        content: "The vets were nice af",
        optional_image: "https://sayingimages.com/wp-content/uploads/You-Got-It-meme.jpg",
        reviewer_name: "#{@user_1.name}",
        user_id: "#{@user_1.id}",
        shelter_id: "#{@shelter_2.id}"})
    end

    it "User can edit review" do
      visit "/shelters/#{@shelter_2.id}"
      click_on "Edit Review"
      expect(current_path).to eq("/shelters/#{@shelter_2.id}/reviews/#{@review_1.id}/edit")

      fill_in "title", with: "Worst Place Ever"
      fill_in "rating", with: 3
      fill_in "content", with: "Don't Come Here"
      fill_in "reviewer_name", with: "#{@user_1.name}"

      click_button "Submit Edit"
      
      expect(current_path).to eq("/shelters/#{@shelter_2.id}")
      expect(page).to have_content("Worst Place Ever")
      expect(page).to have_content(3)
      expect(page).to have_content("Don't Come Here")
      expect(page).to have_content("Mike Dao")
    end
  end
end
