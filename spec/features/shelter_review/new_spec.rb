require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:id' do
    it "User can add a new review for the shelter" do

      @shelter_1 = Shelter.create!(
              name:    "The Feline Fix",
              address:  "6075 Parkway Drive",
              city:     "Denver",
              state:    "CO",
              zip:      "80022")

      @user_1 = User.create!(
        name:     "Mike Dao",
        address:  "123 Taylor Swift Ave",
        city:     "Denver",
        state:    "CO",
        zip:      "80213")


      visit "/shelters/#{@shelter_1.id}"
      click_button "Add Review"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      fill_in "title",      with: "Best Place Ever"
      fill_in "rating",   with: 5
      fill_in "content",      with: "This is the best place ever. Come adopt your pet here"
      select('Mike Dao', from: 'user_id')
      click_button "Submit Review"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      review = Review.last
      expect(page).to have_content("#{review.title}")
      expect(page).to have_content("#{review.rating}")
      expect(page).to have_content("#{review.content}")
      expect(page).to have_content("#{@user_1.name}")
    end
  end
end
