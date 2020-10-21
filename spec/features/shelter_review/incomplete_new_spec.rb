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

    end
      it 'I can not create a new review without a title' do
        visit "/shelters/#{@shelter_1.id}/reviews/new"
        fill_in "rating", with: 5
        fill_in "content", with: "This is the best place ever. Come adopt your pet here"
        fill_in "reviewer_name", with: "#{@user_1.name}"

        click_button "Submit Review"

        expect(page).to have_content("Review not created: Required information missing.")
        expect(page).to have_button("Submit Review")
      end
    end
  end
