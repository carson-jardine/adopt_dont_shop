require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:id' do
    before :each do
      @shelter_1 = Shelter.create(name:    "The Feline Fix",
        address:  "6075 Parkway Drive",
        city:     "Denver",
        state:    "CO",
        zip:      "80022")
      @shelter_2 = Shelter.create(name:    "The Dumb Friends League",
          address:  "2080 S Quebec Street",
          city:     "Denver",
          state:    "CO",
          zip:      "80231")
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

      user_1 = User.create(
        name:     "Mike Dao",
        address:  "123 Taylor Swift Ave",
        city:     "Denver",
        state:    "CO",
        zip:      "80213")

      review_1 = Review.new(
        title: "Best Place Ever",
        rating: 5,
        content: "The vets were nice af",
        optional_image: "no",
        reviewer_name: "#{user_1.name}"
      )

      expect(page).to have_content("#{review_1.title}")
      expect(page).to have_content("#{review_1.rating}")
      expect(page).to have_content("#{review_1.content}")
      expect(page).to have_content("#{review_1.optional_image}")
      expect(page).to have_content("#{review_1.reviewer_name}")

    end
  end
end

# As a visitor,
# When I visit a shelter's show page,
# I see a list of reviews for that shelter
# Each review will have:
# - title
# - rating
# - content
# - an optional picture
# - the name of the user that wrote the review
