require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/shelter_id/reviews/id' do
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
      it 'I can not edit a review without a title/content or rating' do
        visit "/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit"
        fill_in "title",      with: ""
        click_button "Submit Edit"
        expect(page).to have_content("Review not updated: Required information missing")
        expect(page).to have_button("Submit Edit")
      end
    end
  end