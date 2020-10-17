require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /user/id' do
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
    end
    it "shows all of the user's information" do

      visit "/users/#{@user_1.id}"

      expect(page).to have_content("#{@user_1.name}")
      expect(page).to have_content("#{@user_1.address}")
      expect(page).to have_content("#{@user_1.city}")
      expect(page).to have_content("#{@user_1.state}")
      expect(page).to have_content("#{@user_1.zip}")
    end

    it "shows all of the reviews with the review information" do

      visit "/users/#{@user_1.id}"

      expect(page).to have_content("#{@review_1.title}")
      expect(page).to have_content("#{@review_1.rating}")
      expect(page).to have_content("#{@review_1.content}")
      expect(page).to have_content("#{@review_1.reviewer_name}")
      expect(page).to have_xpath("//img[@src='#{@review_1.optional_image}']")

      expect(page).to have_content("#{@review_2.title}")
      expect(page).to have_content("#{@review_2.rating}")
      expect(page).to have_content("#{@review_2.content}")
      expect(page).to have_content("#{@review_2.reviewer_name}")
      expect(page).to have_xpath("//img[@src='#{@review_2.optional_image}']")
    end

    it "Shows the users average review rating" do
      visit "/users/#{@user_1.id}"

      expect(page).to have_content("#{@user_1.average_user_rating}")
    end
  end
end
